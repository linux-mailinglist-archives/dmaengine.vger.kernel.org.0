Return-Path: <dmaengine+bounces-2619-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CEF923156
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jul 2024 10:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCED72816D5
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jul 2024 08:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CAE1474D3;
	Tue,  2 Jul 2024 08:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+bWCwaX"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935F74963F
	for <dmaengine@vger.kernel.org>; Tue,  2 Jul 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719908968; cv=none; b=F1zMmWuWKYS7FHOsZaDLvvwbB5/sJP52Z5y6ltR4QmdHE6/izRWurlit46wo2mr5oiOjqzkpz7rLBn5ZGqcJNgLwCdQ/rwHu/OVDcz3X+cv1YhiZSa8JclMPO73t2+lLbcMmG6ZBnvmWPYgzAOMEqdDDfPB9gCpLizRDixcYfFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719908968; c=relaxed/simple;
	bh=ESsIdQIFVAZrjcgDOnzTD6LdFIQhp1qBDxYPPx4LvlY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SnHxzFXk+rN08pEDCbfERADqKccqZKaVLq9FhiYC0vTiohiXbVpQXlmpWyHf5ufmUTBx/upjILERKWmqhFlUFFluSl36/ozqJVfyJPcrwewunRJswXfX/3l6GrJZuXn9TqyT+UTDvFkpSRtT7OSIS2VA90YeMz+XSBa6M46jwtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+bWCwaX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719908964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESsIdQIFVAZrjcgDOnzTD6LdFIQhp1qBDxYPPx4LvlY=;
	b=N+bWCwaXYd3jDc0Dx+2EG+iRO75yv15uREP/TaraDIlD+hGE+p1Z+JMEBs+EcmotbusMpA
	UMueJ3u8jQ3/tUKv9RKHe9AwVJb35CMKK+HeqARxsXS/IevFWDlxRNriO56XWeC+yv33uY
	QXzc3KGEKWjrejMI+JTaFmTU6CLnV7Y=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-oKeldMg2P0q0LxSOQMsPZQ-1; Tue, 02 Jul 2024 04:29:22 -0400
X-MC-Unique: oKeldMg2P0q0LxSOQMsPZQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52e747b2740so698475e87.1
        for <dmaengine@vger.kernel.org>; Tue, 02 Jul 2024 01:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719908961; x=1720513761;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESsIdQIFVAZrjcgDOnzTD6LdFIQhp1qBDxYPPx4LvlY=;
        b=PLIVnAg5Y6RnSLSTLJwrXfQB44qnydmK9ewwov8NDw3+pSM6OIDm5Dh5YlocWXqL/z
         WryM8XKrTmWP9ArE3tzZTEqEYlovXufDfkxmDEFY4pQ3k6BTM31tLndc4Mg14luF8q9+
         5kNfO3QBMfCXQ4dXykYIXpWNYDYsS/lcdHDB+osNkKkopWJhsFeebTPMOCKnDfg6N6x1
         8w9yFbxx4o74K+KdrKytY3nA9WVU1cnRE0iIZqGg0adX7iC+VmSz0TSVTDzd4JHeZtud
         UQAliCgjdBk0cznqDx9oNyuN+D5Mlr6j1MMv4K7pMwFd6dpUyfxP61H0Y5vFykmHis6P
         WugQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi3Qf3bNApbeKHHo2EOv1UvwdK5f8xLXvMq46bl/ewBXPRKn+VDiT7bJLqMH2n/WWFlG/D5IYuMnqLGDBx/usbqCxVyqlGg6pT
X-Gm-Message-State: AOJu0YxI+9ItvTYt2TlfgzAOTQYwTg+eE8o2Y3521ugtZxabReg86p89
	T99GFsUk7zJSOR2W074uDAJC3r5YBxmCyYqlqeNHwSGgaYnSUXHkYqIKXRGwYwOMpEmGgfTXyVm
	qwcPmAAjfzmxVIiCIrb82TaC5qMfPKe3YumUjPQkvgMS1tcE+U/IW4G5FbA==
X-Received: by 2002:a05:6512:3ca5:b0:52c:deb9:8c4b with SMTP id 2adb3069b0e04-52e825cb5b7mr5123717e87.0.1719908960912;
        Tue, 02 Jul 2024 01:29:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbnKyOZxFszydtJ3j6TVO4ReWTCeZnxHvXPrkqblVJ0rwKsr6id5FKMN6AjByUxtcEAjslVg==
X-Received: by 2002:a05:6512:3ca5:b0:52c:deb9:8c4b with SMTP id 2adb3069b0e04-52e825cb5b7mr5123692e87.0.1719908960464;
        Tue, 02 Jul 2024 01:29:20 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5ba51sm185540825e9.12.2024.07.02.01.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 01:29:20 -0700 (PDT)
Message-ID: <4da57ed28ae9d8bd61a6748f94f78e0d875461a4.camel@redhat.com>
Subject: Re: [PATCH v4 5/7] dmaengine: ae4dma: Register AE4DMA using
 pt_dmaengine_register
From: Philipp Stanner <pstanner@redhat.com>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, vkoul@kernel.org, 
	dmaengine@vger.kernel.org
Cc: Raju.Rangoju@amd.com, Frank.li@nxp.com, helgaas@kernel.org
Date: Tue, 02 Jul 2024 10:29:19 +0200
In-Reply-To: <20240701164233.2563221-6-Basavaraj.Natikar@amd.com>
References: <20240701164233.2563221-1-Basavaraj.Natikar@amd.com>
	 <20240701164233.2563221-6-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI0LTA3LTAxIGF0IDIyOjEyICswNTMwLCBCYXNhdmFyYWogTmF0aWthciB3cm90
ZToKPiBVc2UgdGhlIHB0X2RtYWVuZ2luZV9yZWdpc3RlciBmdW5jdGlvbiB0byByZWdpc3RlciBh
IEFFNERNQSBETUEKPiBlbmdpbmUuCj4gCj4gUmV2aWV3ZWQtYnk6IFJhanUgUmFuZ29qdSA8UmFq
dS5SYW5nb2p1QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogUGhpbGlwcCBTdGFubmVyIDxwc3Rhbm5l
ckByZWRoYXQuY29tPgoKPiBTaWduZWQtb2ZmLWJ5OiBCYXNhdmFyYWogTmF0aWthciA8QmFzYXZh
cmFqLk5hdGlrYXJAYW1kLmNvbT4KPiAtLS0KPiDCoGRyaXZlcnMvZG1hL2FtZC9hZTRkbWEvYWU0
ZG1hLWRldi5jwqDCoMKgwqAgfCA2MAo+ICsrKysrKysrKysrKysrKysrKysrKysrKysKPiDCoGRy
aXZlcnMvZG1hL2FtZC9hZTRkbWEvYWU0ZG1hLXBjaS5jwqDCoMKgwqAgfMKgIDEgKwo+IMKgZHJp
dmVycy9kbWEvYW1kL2FlNGRtYS9hZTRkbWEuaMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKwo+IMKg
ZHJpdmVycy9kbWEvYW1kL3B0ZG1hL3B0ZG1hLWRtYWVuZ2luZS5jIHzCoCAxICsKPiDCoDQgZmls
ZXMgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Rt
YS9hbWQvYWU0ZG1hL2FlNGRtYS1kZXYuYwo+IGIvZHJpdmVycy9kbWEvYW1kL2FlNGRtYS9hZTRk
bWEtZGV2LmMKPiBpbmRleCBjMzg0NjRiOTZmYzYuLjIwNWJiODgyMmY4NCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2RtYS9hbWQvYWU0ZG1hL2FlNGRtYS1kZXYuYwo+ICsrKyBiL2RyaXZlcnMvZG1h
L2FtZC9hZTRkbWEvYWU0ZG1hLWRldi5jCj4gQEAgLTYxLDYgKzYxLDE1IEBAIHN0YXRpYyB2b2lk
IGFlNF9jaGVja19zdGF0dXNfZXJyb3Ioc3RydWN0Cj4gYWU0X2NtZF9xdWV1ZSAqYWU0Y21kX3Es
IGludCBpZHgpCj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDCoH0KPiDCoAo+ICt2b2lkIHB0X2NoZWNr
X3N0YXR1c190cmFucyhzdHJ1Y3QgcHRfZGV2aWNlICpwdCwgc3RydWN0IHB0X2NtZF9xdWV1ZQo+
ICpjbWRfcSkKPiArewo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBhZTRfY21kX3F1ZXVlICphZTRj
bWRfcSA9IGNvbnRhaW5lcl9vZihjbWRfcSwgc3RydWN0Cj4gYWU0X2NtZF9xdWV1ZSwgY21kX3Ep
Owo+ICvCoMKgwqDCoMKgwqDCoGludCBpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBmb3IgKGkgPSAw
OyBpIDwgQ01EX1FfTEVOOyBpKyspCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFl
NF9jaGVja19zdGF0dXNfZXJyb3IoYWU0Y21kX3EsIGkpOwo+ICt9Cj4gKwo+IMKgc3RhdGljIHZv
aWQgYWU0X3BlbmRpbmdfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4gwqB7Cj4gwqDC
oMKgwqDCoMKgwqDCoHN0cnVjdCBhZTRfY21kX3F1ZXVlICphZTRjbWRfcSA9IGNvbnRhaW5lcl9v
Zih3b3JrLCBzdHJ1Y3QKPiBhZTRfY21kX3F1ZXVlLCBwX3dvcmsud29yayk7Cj4gQEAgLTExNyw2
ICsxMjYsNTMgQEAgc3RhdGljIGlycXJldHVybl90IGFlNF9jb3JlX2lycV9oYW5kbGVyKGludCBp
cnEsCj4gdm9pZCAqZGF0YSkKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIElSUV9IQU5ETEVEOwo+
IMKgfQo+IMKgCj4gK3N0YXRpYyBpbnQgYWU0X2NvcmVfZXhlY3V0ZV9jbWQoc3RydWN0IGFlNGRt
YV9kZXNjICpkZXNjLCBzdHJ1Y3QKPiBhZTRfY21kX3F1ZXVlICphZTRjbWRfcSkKPiArewo+ICvC
oMKgwqDCoMKgwqDCoGJvb2wgc29jID0gRklFTERfR0VUKERXT1JEMF9TT0MsIGRlc2MtPmR3b3V2
LmR3MCk7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHB0X2NtZF9xdWV1ZSAqY21kX3EgPSAmYWU0
Y21kX3EtPmNtZF9xOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAoc29jKSB7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRlc2MtPmR3b3V2LmR3MCB8PSBGSUVMRF9QUkVQKERXT1JE
MF9JT0MsIGRlc2MtCj4gPmR3b3V2LmR3MCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGRlc2MtPmR3b3V2LmR3MCAmPSB+RFdPUkQwX1NPQzsKPiArwqDCoMKgwqDCoMKgwqB9Cj4g
Kwo+ICvCoMKgwqDCoMKgwqDCoG11dGV4X2xvY2soJmFlNGNtZF9xLT5jbWRfbG9jayk7Cj4gK8Kg
wqDCoMKgwqDCoMKgbWVtY3B5KCZjbWRfcS0+cWJhc2VbYWU0Y21kX3EtPnRhaWxfd2ldLCBkZXNj
LCBzaXplb2Yoc3RydWN0Cj4gYWU0ZG1hX2Rlc2MpKTsKPiArwqDCoMKgwqDCoMKgwqBhZTRjbWRf
cS0+cV9jbWRfY291bnQrKzsKPiArwqDCoMKgwqDCoMKgwqBhZTRjbWRfcS0+dGFpbF93aSA9IChh
ZTRjbWRfcS0+dGFpbF93aSArIDEpICUgQ01EX1FfTEVOOwo+ICvCoMKgwqDCoMKgwqDCoHdyaXRl
bChhZTRjbWRfcS0+dGFpbF93aSwgY21kX3EtPnJlZ19jb250cm9sICsKPiBBRTRfV1JfSURYX09G
Rik7Cj4gK8KgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2NrKCZhZTRjbWRfcS0+Y21kX2xvY2spOwo+
ICsKPiArwqDCoMKgwqDCoMKgwqB3YWtlX3VwKCZhZTRjbWRfcS0+cV93KTsKPiArCj4gK8KgwqDC
oMKgwqDCoMKgcmV0dXJuIDA7Cj4gK30KPiArCj4gK2ludCBwdF9jb3JlX3BlcmZvcm1fcGFzc3Ro
cnUoc3RydWN0IHB0X2NtZF9xdWV1ZSAqY21kX3EsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcHRfcGFzc3RocnVfZW5naW5l
ICpwdF9lbmdpbmUpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWU0X2NtZF9xdWV1ZSAq
YWU0Y21kX3EgPSBjb250YWluZXJfb2YoY21kX3EsIHN0cnVjdAo+IGFlNF9jbWRfcXVldWUsIGNt
ZF9xKTsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWU0ZG1hX2Rlc2MgZGVzYzsKPiArCj4gK8Kg
wqDCoMKgwqDCoMKgY21kX3EtPmNtZF9lcnJvciA9IDA7Cj4gK8KgwqDCoMKgwqDCoMKgY21kX3Et
PnRvdGFsX3B0X29wcysrOwo+ICvCoMKgwqDCoMKgwqDCoG1lbXNldCgmZGVzYywgMCwgc2l6ZW9m
KGRlc2MpKTsKPiArwqDCoMKgwqDCoMKgwqBkZXNjLmR3b3V2LmR3cy5ieXRlMCA9IENNRF9BRTRf
REVTQ19EVzBfVkFMOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBkZXNjLmR3MS5zdGF0dXMgPSAwOwo+
ICvCoMKgwqDCoMKgwqDCoGRlc2MuZHcxLmVycl9jb2RlID0gMDsKPiArwqDCoMKgwqDCoMKgwqBk
ZXNjLmR3MS5kZXNjX2lkID0gMDsKPiArCj4gK8KgwqDCoMKgwqDCoMKgZGVzYy5sZW5ndGggPSBw
dF9lbmdpbmUtPnNyY19sZW47Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGRlc2Muc3JjX2xvID0gdXBw
ZXJfMzJfYml0cyhwdF9lbmdpbmUtPnNyY19kbWEpOwo+ICvCoMKgwqDCoMKgwqDCoGRlc2Muc3Jj
X2hpID0gbG93ZXJfMzJfYml0cyhwdF9lbmdpbmUtPnNyY19kbWEpOwo+ICvCoMKgwqDCoMKgwqDC
oGRlc2MuZHN0X2xvID0gdXBwZXJfMzJfYml0cyhwdF9lbmdpbmUtPmRzdF9kbWEpOwo+ICvCoMKg
wqDCoMKgwqDCoGRlc2MuZHN0X2hpID0gbG93ZXJfMzJfYml0cyhwdF9lbmdpbmUtPmRzdF9kbWEp
Owo+ICsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gYWU0X2NvcmVfZXhlY3V0ZV9jbWQoJmRlc2Ms
IGFlNGNtZF9xKTsKPiArfQo+ICsKPiDCoHZvaWQgYWU0X2Rlc3Ryb3lfd29yayhzdHJ1Y3QgYWU0
X2RldmljZSAqYWU0KQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWU0X2NtZF9xdWV1
ZSAqYWU0Y21kX3E7Cj4gQEAgLTE5NCw1ICsyNTAsOSBAQCBpbnQgYWU0X2NvcmVfaW5pdChzdHJ1
Y3QgYWU0X2RldmljZSAqYWU0KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW5p
dF9jb21wbGV0aW9uKCZhZTRjbWRfcS0+Y21wKTsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4g
K8KgwqDCoMKgwqDCoMKgcmV0ID0gcHRfZG1hZW5naW5lX3JlZ2lzdGVyKHB0KTsKPiArwqDCoMKg
wqDCoMKgwqBpZiAocmV0KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhZTRfZGVz
dHJveV93b3JrKGFlNCk7Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+IMKgfQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9hbWQvYWU0ZG1hL2FlNGRtYS1wY2kuYwo+IGIvZHJp
dmVycy9kbWEvYW1kL2FlNGRtYS9hZTRkbWEtcGNpLmMKPiBpbmRleCA0M2QzNmU5ZDFlZmIuLmFh
ZDBkYzQyOTRhMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2RtYS9hbWQvYWU0ZG1hL2FlNGRtYS1w
Y2kuYwo+ICsrKyBiL2RyaXZlcnMvZG1hL2FtZC9hZTRkbWEvYWU0ZG1hLXBjaS5jCj4gQEAgLTk4
LDYgKzk4LDcgQEAgc3RhdGljIGludCBhZTRfcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2
LAo+IGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkKPiDCoAo+IMKgwqDCoMKgwqDCoMKg
wqBwdCA9ICZhZTQtPnB0Owo+IMKgwqDCoMKgwqDCoMKgwqBwdC0+ZGV2ID0gZGV2Owo+ICvCoMKg
wqDCoMKgwqDCoHB0LT52ZXIgPSBBRTRfRE1BX1ZFUlNJT047Cj4gwqAKPiDCoMKgwqDCoMKgwqDC
oMKgcHQtPmlvX3JlZ3MgPSBwY2ltX2lvbWFwX3RhYmxlKHBkZXYpWzBdOwo+IMKgwqDCoMKgwqDC
oMKgwqBpZiAoIXB0LT5pb19yZWdzKSB7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2FtZC9h
ZTRkbWEvYWU0ZG1hLmgKPiBiL2RyaXZlcnMvZG1hL2FtZC9hZTRkbWEvYWU0ZG1hLmgKPiBpbmRl
eCA1ZjlkYWI1ZjA1ZjQuLjFiYzhhYmNkMWQ0NCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2RtYS9h
bWQvYWU0ZG1hL2FlNGRtYS5oCj4gKysrIGIvZHJpdmVycy9kbWEvYW1kL2FlNGRtYS9hZTRkbWEu
aAo+IEBAIC0yNSw2ICsyNSw3IEBACj4gwqAjZGVmaW5lIEFFNF9RX1NawqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDB4MjAKPiDCoAo+IMKgI2RlZmluZSBBRTRf
RE1BX1ZFUlNJT07CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqA0Cj4gKyNkZWZpbmUgQ01EX0FFNF9ERVNDX0RXMF9WQUzCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Mgo+IMKgCj4gwqBzdHJ1Y3QgYWU0X21zaXggewo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgbXNpeF9j
b3VudDsKPiBAQCAtNDUsNiArNDYsNyBAQCBzdHJ1Y3QgYWU0X2NtZF9xdWV1ZSB7Cj4gwqDCoMKg
wqDCoMKgwqDCoGF0b21pYzY0X3QgZG9uZV9jbnQ7Cj4gwqDCoMKgwqDCoMKgwqDCoHU2NCBxX2Nt
ZF9jb3VudDsKPiDCoMKgwqDCoMKgwqDCoMKgdTMyIGRyaWR4Owo+ICvCoMKgwqDCoMKgwqDCoHUz
MiB0YWlsX3dpOwo+IMKgwqDCoMKgwqDCoMKgwqB1MzIgaWQ7Cj4gwqB9Owo+IMKgCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZG1hL2FtZC9wdGRtYS9wdGRtYS1kbWFlbmdpbmUuYwo+IGIvZHJpdmVy
cy9kbWEvYW1kL3B0ZG1hL3B0ZG1hLWRtYWVuZ2luZS5jCj4gaW5kZXggOTBjYTAyZmQ1ZjhmLi4x
ZjAyMGY5MGQ4ODYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9kbWEvYW1kL3B0ZG1hL3B0ZG1hLWRt
YWVuZ2luZS5jCj4gKysrIGIvZHJpdmVycy9kbWEvYW1kL3B0ZG1hL3B0ZG1hLWRtYWVuZ2luZS5j
Cj4gQEAgLTQ2Miw2ICs0NjIsNyBAQCBpbnQgcHRfZG1hZW5naW5lX3JlZ2lzdGVyKHN0cnVjdCBw
dF9kZXZpY2UgKnB0KQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gwqB9Cj4g
K0VYUE9SVF9TWU1CT0xfR1BMKHB0X2RtYWVuZ2luZV9yZWdpc3Rlcik7Cj4gwqAKPiDCoHZvaWQg
cHRfZG1hZW5naW5lX3VucmVnaXN0ZXIoc3RydWN0IHB0X2RldmljZSAqcHQpCj4gwqB7Cgo=


