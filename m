Return-Path: <dmaengine+bounces-2416-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B71A790E47F
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 09:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C501C20DF0
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 07:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6027605E;
	Wed, 19 Jun 2024 07:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPXOkF/F"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7E74061
	for <dmaengine@vger.kernel.org>; Wed, 19 Jun 2024 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782170; cv=none; b=GtXQ1I/QmyqiIPCer2As/R+0WMu/gYbujkhuHtvi5HY2TpKFSEwt1o5g5+fTqFkmfL+to4xRMsdpdEhZJVBis40VYIWlNfOpzdOjxpef2NZAsjvh34uFnDrOwujbR2qXYeZud2pz9xQ4XdfoJDuZ2DRIeJ5hz0ry1ElRV+8n96U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782170; c=relaxed/simple;
	bh=aJVLiFvFo6/DkYAopKQMygErUHtXb9CKVhegHOXEjss=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rGXboXfeanypRMpf0i/2vrD8wqUCalnwnHlCkRFFxn75bE5UdDI22RNQlWSW+SKrbIcpOUcqiBbvrbgKrnJ1WZeIH9abDuAP9WNvRKEPC5ewT0ybwRdoHBKXBMUrmN1FkV1IJjQS+R+49wBNMayIJM4fx76Pm6xp3zzJZLRTcwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PPXOkF/F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718782167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJVLiFvFo6/DkYAopKQMygErUHtXb9CKVhegHOXEjss=;
	b=PPXOkF/FUUnA7j6gAGIPB8uiApZ42MDH8b9zYVwrcW5BTp223w/QEh0yBy0C6YXWCKoBPk
	nIe/f75QgxMg5KNvNDLOQKSA/1LzSuYmRfQc1aF9dWl4wK3wcVLtk2CuAPwOL9/FV9ZyfQ
	EDhn2I4YH8tVUhoTKzCM3ePIDElGe6Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-ezg1AC6nP_q1D0b6qzqEdw-1; Wed, 19 Jun 2024 03:29:25 -0400
X-MC-Unique: ezg1AC6nP_q1D0b6qzqEdw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b4fc5c2ee5so1236986d6.3
        for <dmaengine@vger.kernel.org>; Wed, 19 Jun 2024 00:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718782165; x=1719386965;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aJVLiFvFo6/DkYAopKQMygErUHtXb9CKVhegHOXEjss=;
        b=pEsrW/9YRhEv/1PDWT+ALdvbKDMKgzi2g4G5VNKxfoh/657mQGq7uYQJb5zABYvuwo
         Rr2WBbXkWoqRgn1qrtMbMc7yjku6IHa4VWCKT4xa96qwvgNRSZXYBUtext+Tg1IPHytc
         F2oBofuNWG8sz3MYlWcpAgwU8xufuKfBAiBBwKpoIlI64zrFt/p4iNj7li2UDaKHQb+7
         XPqUiR5WiD/kbqQVGqIvk4YZr1rsD1G5EYz7zX0WZUAdYCFEn2z5s7xp7xl2x0s+RmPX
         hjXHshG+3Ob22QHSH0+wOWVhuXa0vyDc9x+dXsG3g5aj5sBiB/vpDBCWP5mCl0OvLhM0
         /2Zg==
X-Forwarded-Encrypted: i=1; AJvYcCV+nccin94htUMP0FzqPrJqgM683F9P2s5dCPdw4Be9xcx+rAty8AqhXvhUpp4DvL9EJIZ2lzW6aPCjSVkE5buoBVrC8/WcmeSz
X-Gm-Message-State: AOJu0YydS1GTMJHZKBkUqzAocfyl1fNVgmMNnHuqPr9CmhddtLMLwy3F
	0SPE49U9WPvhp+5vwd5VkIvkXc/FQxmNbJUbgE837zUvRnACelSbpCQwvCRAO4odosHA3HDDDuo
	f9Tp7YKEV7Yy5c0tjAEJtXyz/X6LJG9vC7tr423qDCVPdko+UoE/2eKhznA==
X-Received: by 2002:a05:6214:c47:b0:6b0:8202:5c4e with SMTP id 6a1803df08f44-6b501ee5529mr19543476d6.5.1718782164896;
        Wed, 19 Jun 2024 00:29:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLnKxTnr0VorEULU29WmOVDJtr3ZD0olQ7m0OuGeisr4KqXtv19Y4Dwlmc14FVU2El2iWHkg==
X-Received: by 2002:a05:6214:c47:b0:6b0:8202:5c4e with SMTP id 6a1803df08f44-6b501ee5529mr19543396d6.5.1718782164595;
        Wed, 19 Jun 2024 00:29:24 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c46633sm73945256d6.69.2024.06.19.00.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:29:24 -0700 (PDT)
Message-ID: <687174ffdd9eeeefab5309b57bf0001c9d4dae76.camel@redhat.com>
Subject: Re: [PATCH v2 5/7] dmaengine: ae4dma: Register AE4DMA using
 pt_dmaengine_register
From: Philipp Stanner <pstanner@redhat.com>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, vkoul@kernel.org, 
	dmaengine@vger.kernel.org
Cc: Raju.Rangoju@amd.com, Frank.li@nxp.com
Date: Wed, 19 Jun 2024 09:29:22 +0200
In-Reply-To: <20240617100359.2550541-6-Basavaraj.Natikar@amd.com>
References: <20240617100359.2550541-1-Basavaraj.Natikar@amd.com>
	 <20240617100359.2550541-6-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI0LTA2LTE3IGF0IDE1OjMzICswNTMwLCBCYXNhdmFyYWogTmF0aWthciB3cm90
ZToKPiBVc2UgdGhlIHB0X2RtYWVuZ2luZV9yZWdpc3RlciBmdW5jdGlvbiB0byByZWdpc3RlciBh
IEFFNERNQSBETUEKPiBlbmdpbmUuCj4gCj4gUmV2aWV3ZWQtYnk6IFJhanUgUmFuZ29qdSA8UmFq
dS5SYW5nb2p1QGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQmFzYXZhcmFqIE5hdGlrYXIgPEJh
c2F2YXJhai5OYXRpa2FyQGFtZC5jb20+Cj4gLS0tCj4gwqBkcml2ZXJzL2RtYS9hbWQvYWU0ZG1h
L01ha2VmaWxlwqDCoMKgwqAgfMKgIDIgKy0KPiDCoGRyaXZlcnMvZG1hL2FtZC9hZTRkbWEvYWU0
ZG1hLWRldi5jIHwgNzMKPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+IMKgZHJpdmVy
cy9kbWEvYW1kL2FlNGRtYS9hZTRkbWEtcGNpLmMgfMKgIDEgKwo+IMKgZHJpdmVycy9kbWEvYW1k
L2FlNGRtYS9hZTRkbWEuaMKgwqDCoMKgIHzCoCAyICsKPiDCoDQgZmlsZXMgY2hhbmdlZCwgNzcg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Rt
YS9hbWQvYWU0ZG1hL01ha2VmaWxlCj4gYi9kcml2ZXJzL2RtYS9hbWQvYWU0ZG1hL01ha2VmaWxl
Cj4gaW5kZXggZTkxOGY4NWE4MGVjLi4xNjVkMWM3NGI3MzIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9kbWEvYW1kL2FlNGRtYS9NYWtlZmlsZQo+ICsrKyBiL2RyaXZlcnMvZG1hL2FtZC9hZTRkbWEv
TWFrZWZpbGUKPiBAQCAtNSw2ICs1LDYgQEAKPiDCoAo+IMKgb2JqLSQoQ09ORklHX0FNRF9BRTRE
TUEpICs9IGFlNGRtYS5vCj4gwqAKPiAtYWU0ZG1hLW9ianMgOj0gYWU0ZG1hLWRldi5vCj4gK2Fl
NGRtYS1vYmpzIDo9IGFlNGRtYS1kZXYub8KgIC4uL3B0ZG1hL3B0ZG1hLWRtYWVuZ2luZS5vCj4g
Li4vY29tbW9uL2FtZF9kbWEubwo+IMKgCj4gwqBhZTRkbWEtJChDT05GSUdfUENJKSArPSBhZTRk
bWEtcGNpLm8KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvYW1kL2FlNGRtYS9hZTRkbWEtZGV2
LmMKPiBiL2RyaXZlcnMvZG1hL2FtZC9hZTRkbWEvYWU0ZG1hLWRldi5jCj4gaW5kZXggOTU4YmRh
YjhkYjU5Li43N2MzNzY0OWQ4ZDEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9kbWEvYW1kL2FlNGRt
YS9hZTRkbWEtZGV2LmMKPiArKysgYi9kcml2ZXJzL2RtYS9hbWQvYWU0ZG1hL2FlNGRtYS1kZXYu
Ywo+IEBAIC02MCw2ICs2MCwxNSBAQCBzdGF0aWMgdm9pZCBhZTRfY2hlY2tfc3RhdHVzX2Vycm9y
KHN0cnVjdAo+IGFlNF9jbWRfcXVldWUgKmFlNGNtZF9xLCBpbnQgaWR4KQo+IMKgwqDCoMKgwqDC
oMKgwqB9Cj4gwqB9Cj4gwqAKPiArdm9pZCBwdF9jaGVja19zdGF0dXNfdHJhbnMoc3RydWN0IHB0
X2RldmljZSAqcHQsIHN0cnVjdCBwdF9jbWRfcXVldWUKPiAqY21kX3EpCj4gK3sKPiArwqDCoMKg
wqDCoMKgwqBzdHJ1Y3QgYWU0X2NtZF9xdWV1ZSAqYWU0Y21kX3EgPSBjb250YWluZXJfb2YoY21k
X3EsIHN0cnVjdAo+IGFlNF9jbWRfcXVldWUsIGNtZF9xKTsKPiArwqDCoMKgwqDCoMKgwqBpbnQg
aTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgZm9yIChpID0gMDsgaSA8IENNRF9RX0xFTjsgaSsrKQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhZTRfY2hlY2tfc3RhdHVzX2Vycm9yKGFl
NGNtZF9xLCBpKTsKPiArfQo+ICsKPiDCoHN0YXRpYyB2b2lkIGFlNF9wZW5kaW5nX3dvcmsoc3Ry
dWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWU0
X2NtZF9xdWV1ZSAqYWU0Y21kX3EgPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0Cj4gYWU0X2Nt
ZF9xdWV1ZSwgcF93b3JrLndvcmspOwo+IEBAIC0xMjMsNiArMTMyLDY2IEBAIHN0YXRpYyBpcnFy
ZXR1cm5fdCBhZTRfY29yZV9pcnFfaGFuZGxlcihpbnQgaXJxLAo+IHZvaWQgKmRhdGEpCj4gwqDC
oMKgwqDCoMKgwqDCoHJldHVybiBJUlFfSEFORExFRDsKPiDCoH0KPiDCoAo+ICtzdGF0aWMgaW50
IGFlNF9jb3JlX2V4ZWN1dGVfY21kKHN0cnVjdCBhZTRkbWFfZGVzYyAqZGVzYywgc3RydWN0Cj4g
YWU0X2NtZF9xdWV1ZSAqYWU0Y21kX3EpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqBib29sIHNvYyA9
IEZJRUxEX0dFVChEV09SRDBfU09DLCBkZXNjLT5kd291di5kdzApOwo+ICvCoMKgwqDCoMKgwqDC
oHN0cnVjdCBwdF9jbWRfcXVldWUgKmNtZF9xID0gJmFlNGNtZF9xLT5jbWRfcTsKPiArwqDCoMKg
wqDCoMKgwqB1MzIgdGFpbF93aTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHNvYykgewo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXNjLT5kd291di5kdzAgfD0gRklFTERfUFJF
UChEV09SRDBfSU9DLCBkZXNjLQo+ID5kd291di5kdzApOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBkZXNjLT5kd291di5kdzAgJj0gfkRXT1JEMF9TT0M7Cj4gK8KgwqDCoMKgwqDC
oMKgfQo+ICsKPiArwqDCoMKgwqDCoMKgwqBtdXRleF9sb2NrKCZhZTRjbWRfcS0+Y21kX2xvY2sp
Owo+ICsKPiArwqDCoMKgwqDCoMKgwqB0YWlsX3dpID0gYXRvbWljX3JlYWQoJmFlNGNtZF9xLT50
YWlsX3dpKTsKPiArwqDCoMKgwqDCoMKgwqBtZW1jcHkoJmNtZF9xLT5xYmFzZVt0YWlsX3dpXSwg
ZGVzYywgc2l6ZW9mKHN0cnVjdAo+IGFlNGRtYV9kZXNjKSk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDC
oGF0b21pYzY0X2luYygmYWU0Y21kX3EtPnFfY21kX2NvdW50KTsKPiArCj4gK8KgwqDCoMKgwqDC
oMKgdGFpbF93aSA9ICh0YWlsX3dpICsgMSkgJSBDTURfUV9MRU47Cj4gKwo+ICvCoMKgwqDCoMKg
wqDCoGF0b21pY19zZXQoJmFlNGNtZF9xLT50YWlsX3dpLCB0YWlsX3dpKTsKPiArwqDCoMKgwqDC
oMKgwqAvKiBTeW5jaHJvbml6ZSBvcmRlcmluZyAqLwo+ICvCoMKgwqDCoMKgwqDCoG1iKCk7Cj4g
Kwo+ICvCoMKgwqDCoMKgwqDCoHdyaXRlbCh0YWlsX3dpLCBjbWRfcS0+cmVnX2NvbnRyb2wgKyAw
eDEwKTsKPiArwqDCoMKgwqDCoMKgwqAvKiBTeW5jaHJvbml6ZSBvcmRlcmluZyAqLwo+ICvCoMKg
wqDCoMKgwqDCoG1iKCk7CgpTYW1lIGhlcmUgYXMgaW4gcGF0Y2gg4oSWMiwgSSB0aGluayB3cml0
ZWwoKSBhbmQgbXV0ZXggY2FuJ3QgY2hhbmdlIHRoZWlyCnJlbGF0aXZlIG9yZGVyLgoKPiArCj4g
K8KgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2NrKCZhZTRjbWRfcS0+Y21kX2xvY2spOwoKU2FtZSBx
dWVzdGlvbjogY2FuJ3QgZXZlcnl0aGluZyBiZSBkb25lIGJ5IHRoZSBtdXRleCBhbG9uZT8KCgpQ
LgoKPiArCj4gK8KgwqDCoMKgwqDCoMKgd2FrZV91cCgmYWU0Y21kX3EtPnFfdyk7Cj4gKwo+ICvC
oMKgwqDCoMKgwqDCoHJldHVybiAwOwo+ICt9Cj4gKwo+ICtpbnQgcHRfY29yZV9wZXJmb3JtX3Bh
c3N0aHJ1KHN0cnVjdCBwdF9jbWRfcXVldWUgKmNtZF9xLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHB0X3Bhc3N0aHJ1X2Vu
Z2luZSAqcHRfZW5naW5lKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGFlNF9jbWRfcXVl
dWUgKmFlNGNtZF9xID0gY29udGFpbmVyX29mKGNtZF9xLCBzdHJ1Y3QKPiBhZTRfY21kX3F1ZXVl
LCBjbWRfcSk7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGFlNGRtYV9kZXNjIGRlc2M7Cj4gKwo+
ICvCoMKgwqDCoMKgwqDCoGNtZF9xLT5jbWRfZXJyb3IgPSAwOwo+ICvCoMKgwqDCoMKgwqDCoGNt
ZF9xLT50b3RhbF9wdF9vcHMrKzsKPiArwqDCoMKgwqDCoMKgwqBtZW1zZXQoJmRlc2MsIDAsIHNp
emVvZihkZXNjKSk7Cj4gK8KgwqDCoMKgwqDCoMKgZGVzYy5kd291di5kd3MuYnl0ZTAgPSBDTURf
QUU0X0RFU0NfRFcwX1ZBTDsKPiArCj4gK8KgwqDCoMKgwqDCoMKgZGVzYy5kdzEuc3RhdHVzID0g
MDsKPiArwqDCoMKgwqDCoMKgwqBkZXNjLmR3MS5lcnJfY29kZSA9IDA7Cj4gK8KgwqDCoMKgwqDC
oMKgZGVzYy5kdzEuZGVzY19pZCA9IDA7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGRlc2MubGVuZ3Ro
ID0gcHRfZW5naW5lLT5zcmNfbGVuOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBkZXNjLnNyY19sbyA9
IHVwcGVyXzMyX2JpdHMocHRfZW5naW5lLT5zcmNfZG1hKTsKPiArwqDCoMKgwqDCoMKgwqBkZXNj
LnNyY19oaSA9IGxvd2VyXzMyX2JpdHMocHRfZW5naW5lLT5zcmNfZG1hKTsKPiArwqDCoMKgwqDC
oMKgwqBkZXNjLmRzdF9sbyA9IHVwcGVyXzMyX2JpdHMocHRfZW5naW5lLT5kc3RfZG1hKTsKPiAr
wqDCoMKgwqDCoMKgwqBkZXNjLmRzdF9oaSA9IGxvd2VyXzMyX2JpdHMocHRfZW5naW5lLT5kc3Rf
ZG1hKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIGFlNF9jb3JlX2V4ZWN1dGVfY21kKCZk
ZXNjLCBhZTRjbWRfcSk7Cj4gK30KPiArCj4gwqB2b2lkIGFlNF9kZXN0cm95X3dvcmsoc3RydWN0
IGFlNF9kZXZpY2UgKmFlNCkKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGFlNF9jbWRf
cXVldWUgKmFlNGNtZF9xOwo+IEBAIC0yMDIsNSArMjcxLDkgQEAgaW50IGFlNF9jb3JlX2luaXQo
c3RydWN0IGFlNF9kZXZpY2UgKmFlNCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGluaXRfY29tcGxldGlvbigmYWU0Y21kX3EtPmNtcCk7Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDC
oAo+ICvCoMKgwqDCoMKgwqDCoHJldCA9IHB0X2RtYWVuZ2luZV9yZWdpc3RlcihwdCk7Cj4gK8Kg
wqDCoMKgwqDCoMKgaWYgKHJldCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWU0
X2Rlc3Ryb3lfd29yayhhZTQpOwo+ICsKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiDC
oH0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvYW1kL2FlNGRtYS9hZTRkbWEtcGNpLmMKPiBi
L2RyaXZlcnMvZG1hL2FtZC9hZTRkbWEvYWU0ZG1hLXBjaS5jCj4gaW5kZXggZGRlYmYwNjA5YzRk
Li41NDUwZmE1NTFlZWEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9kbWEvYW1kL2FlNGRtYS9hZTRk
bWEtcGNpLmMKPiArKysgYi9kcml2ZXJzL2RtYS9hbWQvYWU0ZG1hL2FlNGRtYS1wY2kuYwo+IEBA
IC0xMzEsNiArMTMxLDcgQEAgc3RhdGljIGludCBhZTRfcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2
ICpwZGV2LAo+IGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkKPiDCoAo+IMKgwqDCoMKg
wqDCoMKgwqBwdCA9ICZhZTQtPnB0Owo+IMKgwqDCoMKgwqDCoMKgwqBwdC0+ZGV2ID0gZGV2Owo+
ICvCoMKgwqDCoMKgwqDCoHB0LT52ZXIgPSBBRTRfRE1BX1ZFUlNJT047Cj4gwqAKPiDCoMKgwqDC
oMKgwqDCoMKgcHQtPmlvX3JlZ3MgPSBwY2ltX2lvbWFwX3RhYmxlKHBkZXYpWzBdOwo+IMKgwqDC
oMKgwqDCoMKgwqBpZiAoIXB0LT5pb19yZWdzKSB7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1h
L2FtZC9hZTRkbWEvYWU0ZG1hLmgKPiBiL2RyaXZlcnMvZG1hL2FtZC9hZTRkbWEvYWU0ZG1hLmgK
PiBpbmRleCA0ZTQ1ODRlMTUyYTEuLmYxYjZkY2MxZDhjMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2RtYS9hbWQvYWU0ZG1hL2FlNGRtYS5oCj4gKysrIGIvZHJpdmVycy9kbWEvYW1kL2FlNGRtYS9h
ZTRkbWEuaAo+IEBAIC0xNiw2ICsxNiw3IEBACj4gwqAKPiDCoCNkZWZpbmUgQUU0X0RFU0NfQ09N
UExFVEVEwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAweDMKPiDCoCNkZWZpbmUgQUU0X0RNQV9W
RVJTSU9OwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgNAo+
ICsjZGVmaW5lIENNRF9BRTRfREVTQ19EVzBfVkFMwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDIKPiDC
oAo+IMKgc3RydWN0IGFlNF9tc2l4IHsKPiDCoMKgwqDCoMKgwqDCoMKgaW50IG1zaXhfY291bnQ7
Cj4gQEAgLTM2LDYgKzM3LDcgQEAgc3RydWN0IGFlNF9jbWRfcXVldWUgewo+IMKgwqDCoMKgwqDC
oMKgwqBhdG9taWM2NF90IGRvbmVfY250Owo+IMKgwqDCoMKgwqDCoMKgwqBhdG9taWM2NF90IHFf
Y21kX2NvdW50Owo+IMKgwqDCoMKgwqDCoMKgwqBhdG9taWNfdCBkcmlkeDsKPiArwqDCoMKgwqDC
oMKgwqBhdG9taWNfdCB0YWlsX3dpOwo+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgaWQ7
Cj4gwqB9Owo+IMKgCgo=


