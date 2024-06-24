Return-Path: <dmaengine+bounces-2524-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D3091450B
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 10:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B341F23B08
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 08:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329234F201;
	Mon, 24 Jun 2024 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuqyyuAX"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E4A7E0F6
	for <dmaengine@vger.kernel.org>; Mon, 24 Jun 2024 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218304; cv=none; b=bjfWlmy7NIcT8FoWgWyf3Zsh5+Fr0GU34rb0zskmtEXvmgx+l/8qdl5Avz7D0diEUa3Zx7EdOK/IzUuy9Bb2MSp/UFQHbqJn7mziDSndiDXO/I+SDtzGhjTkFAXsv5LJhm+kuq7eHGqOLCKPCqf4hWSP6uVI1jWP4l09/HwuugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218304; c=relaxed/simple;
	bh=MqVG2ndMbYkVnwaLN7MZ9aGVK2ofqIrdSl6bMp1q6xg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YOa1fldAywmr0h9Y4oQNAEli/a3BucKERyxLlRGfFpvqW8LxCPHzDgC951rC+eBJwWFAyuYDnPAlwC9bWIKIDrd3COs0O0wAuJK1KEVxG3aCaEtz9qOVjIrIsyBSYLZYNDKnpa4OUVZY/055BSUAeZUNkEOlAw8G5HljihbSeJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DuqyyuAX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719218301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqVG2ndMbYkVnwaLN7MZ9aGVK2ofqIrdSl6bMp1q6xg=;
	b=DuqyyuAXKoDb4JjRTrG9ESuPRYceRShigaAzrCMiQfbxBT0nG5nhiRQOdyLiHXLUGE/wxG
	5uW7CE3K5PPKuh6NLVpWCz1/zE1jYYtIz+QiwVanDUzM0Hv5e7a8lX0wNipl0Xp2M9NNgL
	rW2zt03UkJyjnEojV0JskmD543hacL0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-FUb2t_YZNqS1jRocORIIOQ-1; Mon, 24 Jun 2024 04:38:14 -0400
X-MC-Unique: FUb2t_YZNqS1jRocORIIOQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ec5ee395f4so1429081fa.0
        for <dmaengine@vger.kernel.org>; Mon, 24 Jun 2024 01:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719218293; x=1719823093;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqVG2ndMbYkVnwaLN7MZ9aGVK2ofqIrdSl6bMp1q6xg=;
        b=w2WHRG1/WhklSvtxr6MXI/HNtNyiKh+QYz2gINEpiHt3kCks8SgkmKMR82hZtkHJjY
         mYtqJNBOL+Nbf/MASojD7uX8l/QkIgKQcKj+Wlrq9VW/+eKNEk5UD5hrh+hYNdRDjHSI
         4yBOLhs9UTwMrimOnE4SKYYcCHEQ7g3yx8LUdXLLlbu5rgMYJkSWUQzrktkMz/+82axg
         DASQVjhPBrrxzeL16sltBjIU7Jw8dmey6+b10I4imfkCf2TK0MXgL4/9eHYGCMf45uXE
         wQFq3lYMNVQQdnYCO1XwVCFnS7/D3lBKTtUgFLy+RA7QohgC2cUZUpFN5ZHnG5BBKLc5
         rXCw==
X-Forwarded-Encrypted: i=1; AJvYcCUcilxLJmvOaBUf9AOu2av4LsG8KwGjQg2uHBoj16hExHIhjT9wGyLKBhCCIef23J58LigKiDYlAi1wdOI9yL7Bd9YPf4c41oNM
X-Gm-Message-State: AOJu0YzW5iz4iG5EGa7Eo9NxNO0vK02P4gfTykoCIGnWjlollJyigXeR
	HKL3cEee9kyrNFZ+Qa15NAQDn2tXSXhBb31VH5sloI9KfkW6/jwjsZR0D3lt12Mgwbp+BGpRKox
	7c2Cz5QN86aV2lkT18eU0Q12RWYH89woz5QRZ4GQF9YjqlyRFNc2rT181hA==
X-Received: by 2002:a2e:9903:0:b0:2ec:4176:dcaf with SMTP id 38308e7fff4ca-2ec54ce1c2bmr31995291fa.3.1719218293249;
        Mon, 24 Jun 2024 01:38:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/ZePCR4A1Qr3v7ORIljgjA62pPEXAKudzizSo4jzEPMIiphsOgrAZalr1Lw7pxU+AT+9tbQ==
X-Received: by 2002:a2e:9903:0:b0:2ec:4176:dcaf with SMTP id 38308e7fff4ca-2ec54ce1c2bmr31995241fa.3.1719218292886;
        Mon, 24 Jun 2024 01:38:12 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f6d02sm9319117f8f.85.2024.06.24.01.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:38:12 -0700 (PDT)
Message-ID: <3aafb9fb1fbafef2dbee7c929a89fdd58703cbfb.camel@redhat.com>
Subject: Re: [PATCH v3 5/7] dmaengine: ae4dma: Register AE4DMA using
 pt_dmaengine_register
From: Philipp Stanner <pstanner@redhat.com>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, vkoul@kernel.org, 
	dmaengine@vger.kernel.org
Cc: Raju.Rangoju@amd.com, Frank.li@nxp.com, helgaas@kernel.org
Date: Mon, 24 Jun 2024 10:38:11 +0200
In-Reply-To: <20240624075610.1659502-6-Basavaraj.Natikar@amd.com>
References: <20240624075610.1659502-1-Basavaraj.Natikar@amd.com>
	 <20240624075610.1659502-6-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI0LTA2LTI0IGF0IDEzOjI2ICswNTMwLCBCYXNhdmFyYWogTmF0aWthciB3cm90
ZToKPiBVc2UgdGhlIHB0X2RtYWVuZ2luZV9yZWdpc3RlciBmdW5jdGlvbiB0byByZWdpc3RlciBh
IEFFNERNQSBETUEKPiBlbmdpbmUuCj4gCj4gUmV2aWV3ZWQtYnk6IFJhanUgUmFuZ29qdSA8UmFq
dS5SYW5nb2p1QGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQmFzYXZhcmFqIE5hdGlrYXIgPEJh
c2F2YXJhai5OYXRpa2FyQGFtZC5jb20+Cj4gLS0tCj4gwqBkcml2ZXJzL2RtYS9hbWQvYWU0ZG1h
L2FlNGRtYS1kZXYuY8KgwqDCoMKgIHwgNjUKPiArKysrKysrKysrKysrKysrKysrKysrKysrCj4g
wqBkcml2ZXJzL2RtYS9hbWQvYWU0ZG1hL2FlNGRtYS1wY2kuY8KgwqDCoMKgIHzCoCAxICsKPiDC
oGRyaXZlcnMvZG1hL2FtZC9hZTRkbWEvYWU0ZG1hLmjCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICsK
PiDCoGRyaXZlcnMvZG1hL2FtZC9wdGRtYS9wdGRtYS1kbWFlbmdpbmUuYyB8wqAgMSArCj4gwqA0
IGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9kbWEvYW1kL2FlNGRtYS9hZTRkbWEtZGV2LmMKPiBiL2RyaXZlcnMvZG1hL2FtZC9hZTRkbWEv
YWU0ZG1hLWRldi5jCj4gaW5kZXggY2IwNWZjYjQ3OTg3Li45YWI3NGZjMjI3Y2IgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9kbWEvYW1kL2FlNGRtYS9hZTRkbWEtZGV2LmMKPiArKysgYi9kcml2ZXJz
L2RtYS9hbWQvYWU0ZG1hL2FlNGRtYS1kZXYuYwo+IEBAIC01OCw2ICs1OCwxNSBAQCBzdGF0aWMg
dm9pZCBhZTRfY2hlY2tfc3RhdHVzX2Vycm9yKHN0cnVjdAo+IGFlNF9jbWRfcXVldWUgKmFlNGNt
ZF9xLCBpbnQgaWR4KQo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqB9Cj4gwqAKPiArdm9pZCBwdF9j
aGVja19zdGF0dXNfdHJhbnMoc3RydWN0IHB0X2RldmljZSAqcHQsIHN0cnVjdCBwdF9jbWRfcXVl
dWUKPiAqY21kX3EpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWU0X2NtZF9xdWV1ZSAq
YWU0Y21kX3EgPSBjb250YWluZXJfb2YoY21kX3EsIHN0cnVjdAo+IGFlNF9jbWRfcXVldWUsIGNt
ZF9xKTsKPiArwqDCoMKgwqDCoMKgwqBpbnQgaTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgZm9yIChp
ID0gMDsgaSA8IENNRF9RX0xFTjsgaSsrKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBhZTRfY2hlY2tfc3RhdHVzX2Vycm9yKGFlNGNtZF9xLCBpKTsKPiArfQo+ICsKPiDCoHN0YXRp
YyB2b2lkIGFlNF9wZW5kaW5nX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+IMKgewo+
IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWU0X2NtZF9xdWV1ZSAqYWU0Y21kX3EgPSBjb250YWlu
ZXJfb2Yod29yaywgc3RydWN0Cj4gYWU0X2NtZF9xdWV1ZSwgcF93b3JrLndvcmspOwo+IEBAIC0x
MTcsNiArMTI2LDU4IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBhZTRfY29yZV9pcnFfaGFuZGxlcihp
bnQgaXJxLAo+IHZvaWQgKmRhdGEpCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBJUlFfSEFORExF
RDsKPiDCoH0KPiDCoAo+ICtzdGF0aWMgaW50IGFlNF9jb3JlX2V4ZWN1dGVfY21kKHN0cnVjdCBh
ZTRkbWFfZGVzYyAqZGVzYywgc3RydWN0Cj4gYWU0X2NtZF9xdWV1ZSAqYWU0Y21kX3EpCj4gK3sK
PiArwqDCoMKgwqDCoMKgwqBib29sIHNvYyA9IEZJRUxEX0dFVChEV09SRDBfU09DLCBkZXNjLT5k
d291di5kdzApOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBwdF9jbWRfcXVldWUgKmNtZF9xID0g
JmFlNGNtZF9xLT5jbWRfcTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHNvYykgewo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXNjLT5kd291di5kdzAgfD0gRklFTERfUFJFUChE
V09SRDBfSU9DLCBkZXNjLQo+ID5kd291di5kdzApOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBkZXNjLT5kd291di5kdzAgJj0gfkRXT1JEMF9TT0M7Cj4gK8KgwqDCoMKgwqDCoMKg
fQo+ICsKPiArwqDCoMKgwqDCoMKgwqBtdXRleF9sb2NrKCZhZTRjbWRfcS0+Y21kX2xvY2spOwo+
ICsKPiArwqDCoMKgwqDCoMKgwqBtZW1jcHkoJmNtZF9xLT5xYmFzZVthZTRjbWRfcS0+dGFpbF93
aV0sIGRlc2MsIHNpemVvZihzdHJ1Y3QKPiBhZTRkbWFfZGVzYykpOwo+ICsKPiArwqDCoMKgwqDC
oMKgwqBhZTRjbWRfcS0+cV9jbWRfY291bnQrKzsKPiArCj4gK8KgwqDCoMKgwqDCoMKgYWU0Y21k
X3EtPnRhaWxfd2kgPSAoYWU0Y21kX3EtPnRhaWxfd2kgKyAxKSAlIENNRF9RX0xFTjsKPiArCj4g
K8KgwqDCoMKgwqDCoMKgd3JpdGVsKGFlNGNtZF9xLT50YWlsX3dpLCBjbWRfcS0+cmVnX2NvbnRy
b2wgKyAweDEwKTsKCm1hZ2ljIG51bWJlciAweDEwPwoKPiArCj4gK8KgwqDCoMKgwqDCoMKgbXV0
ZXhfdW5sb2NrKCZhZTRjbWRfcS0+Y21kX2xvY2spOwo+ICsKPiArwqDCoMKgwqDCoMKgwqB3YWtl
X3VwKCZhZTRjbWRfcS0+cV93KTsKCm5pdDogSSdkIHJlbW92ZSB0aGUgYmxhbmsgbGluZXMgYW5k
IGNyZWF0ZSBhIGJsb2NrIGNvbnNpc3Rpbmcgb2YgdGhlCm11dGV4ZXMuCgpUaGFua3MsClAuCgoK
PiArCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gK30KPiArCj4gK2ludCBwdF9jb3JlX3Bl
cmZvcm1fcGFzc3RocnUoc3RydWN0IHB0X2NtZF9xdWV1ZSAqY21kX3EsCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcHRfcGFz
c3RocnVfZW5naW5lICpwdF9lbmdpbmUpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWU0
X2NtZF9xdWV1ZSAqYWU0Y21kX3EgPSBjb250YWluZXJfb2YoY21kX3EsIHN0cnVjdAo+IGFlNF9j
bWRfcXVldWUsIGNtZF9xKTsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWU0ZG1hX2Rlc2MgZGVz
YzsKPiArCj4gK8KgwqDCoMKgwqDCoMKgY21kX3EtPmNtZF9lcnJvciA9IDA7Cj4gK8KgwqDCoMKg
wqDCoMKgY21kX3EtPnRvdGFsX3B0X29wcysrOwo+ICvCoMKgwqDCoMKgwqDCoG1lbXNldCgmZGVz
YywgMCwgc2l6ZW9mKGRlc2MpKTsKPiArwqDCoMKgwqDCoMKgwqBkZXNjLmR3b3V2LmR3cy5ieXRl
MCA9IENNRF9BRTRfREVTQ19EVzBfVkFMOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBkZXNjLmR3MS5z
dGF0dXMgPSAwOwo+ICvCoMKgwqDCoMKgwqDCoGRlc2MuZHcxLmVycl9jb2RlID0gMDsKPiArwqDC
oMKgwqDCoMKgwqBkZXNjLmR3MS5kZXNjX2lkID0gMDsKPiArCj4gK8KgwqDCoMKgwqDCoMKgZGVz
Yy5sZW5ndGggPSBwdF9lbmdpbmUtPnNyY19sZW47Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGRlc2Mu
c3JjX2xvID0gdXBwZXJfMzJfYml0cyhwdF9lbmdpbmUtPnNyY19kbWEpOwo+ICvCoMKgwqDCoMKg
wqDCoGRlc2Muc3JjX2hpID0gbG93ZXJfMzJfYml0cyhwdF9lbmdpbmUtPnNyY19kbWEpOwo+ICvC
oMKgwqDCoMKgwqDCoGRlc2MuZHN0X2xvID0gdXBwZXJfMzJfYml0cyhwdF9lbmdpbmUtPmRzdF9k
bWEpOwo+ICvCoMKgwqDCoMKgwqDCoGRlc2MuZHN0X2hpID0gbG93ZXJfMzJfYml0cyhwdF9lbmdp
bmUtPmRzdF9kbWEpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gYWU0X2NvcmVfZXhlY3V0
ZV9jbWQoJmRlc2MsIGFlNGNtZF9xKTsKPiArfQo+ICsKPiDCoHZvaWQgYWU0X2Rlc3Ryb3lfd29y
ayhzdHJ1Y3QgYWU0X2RldmljZSAqYWU0KQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
YWU0X2NtZF9xdWV1ZSAqYWU0Y21kX3E7Cj4gQEAgLTE5Niw1ICsyNTcsOSBAQCBpbnQgYWU0X2Nv
cmVfaW5pdChzdHJ1Y3QgYWU0X2RldmljZSAqYWU0KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgaW5pdF9jb21wbGV0aW9uKCZhZTRjbWRfcS0+Y21wKTsKPiDCoMKgwqDCoMKgwqDC
oMKgfQo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gcHRfZG1hZW5naW5lX3JlZ2lzdGVyKHB0
KTsKPiArwqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBhZTRfZGVzdHJveV93b3JrKGFlNCk7Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
cmV0Owo+IMKgfQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9hbWQvYWU0ZG1hL2FlNGRtYS1w
Y2kuYwo+IGIvZHJpdmVycy9kbWEvYW1kL2FlNGRtYS9hZTRkbWEtcGNpLmMKPiBpbmRleCA0M2Qz
NmU5ZDFlZmIuLmFhZDBkYzQyOTRhMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2RtYS9hbWQvYWU0
ZG1hL2FlNGRtYS1wY2kuYwo+ICsrKyBiL2RyaXZlcnMvZG1hL2FtZC9hZTRkbWEvYWU0ZG1hLXBj
aS5jCj4gQEAgLTk4LDYgKzk4LDcgQEAgc3RhdGljIGludCBhZTRfcGNpX3Byb2JlKHN0cnVjdCBw
Y2lfZGV2ICpwZGV2LAo+IGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkKPiDCoAo+IMKg
wqDCoMKgwqDCoMKgwqBwdCA9ICZhZTQtPnB0Owo+IMKgwqDCoMKgwqDCoMKgwqBwdC0+ZGV2ID0g
ZGV2Owo+ICvCoMKgwqDCoMKgwqDCoHB0LT52ZXIgPSBBRTRfRE1BX1ZFUlNJT047Cj4gwqAKPiDC
oMKgwqDCoMKgwqDCoMKgcHQtPmlvX3JlZ3MgPSBwY2ltX2lvbWFwX3RhYmxlKHBkZXYpWzBdOwo+
IMKgwqDCoMKgwqDCoMKgwqBpZiAoIXB0LT5pb19yZWdzKSB7Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZG1hL2FtZC9hZTRkbWEvYWU0ZG1hLmgKPiBiL2RyaXZlcnMvZG1hL2FtZC9hZTRkbWEvYWU0
ZG1hLmgKPiBpbmRleCA4NTBhZDFlNDliNTEuLjY2OGZhZDc4MDMxNCAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2RtYS9hbWQvYWU0ZG1hL2FlNGRtYS5oCj4gKysrIGIvZHJpdmVycy9kbWEvYW1kL2Fl
NGRtYS9hZTRkbWEuaAo+IEBAIC0xNiw2ICsxNiw3IEBACj4gwqAKPiDCoCNkZWZpbmUgQUU0X0RF
U0NfQ09NUExFVEVEwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAweDMKPiDCoCNkZWZpbmUgQUU0
X0RNQV9WRVJTSU9OwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgNAo+ICsjZGVmaW5lIENNRF9BRTRfREVTQ19EVzBfVkFMwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oDIKPiDCoAo+IMKgc3RydWN0IGFlNF9tc2l4IHsKPiDCoMKgwqDCoMKgwqDCoMKgaW50IG1zaXhf
Y291bnQ7Cj4gQEAgLTM2LDYgKzM3LDcgQEAgc3RydWN0IGFlNF9jbWRfcXVldWUgewo+IMKgwqDC
oMKgwqDCoMKgwqBhdG9taWM2NF90IGRvbmVfY250Owo+IMKgwqDCoMKgwqDCoMKgwqB1NjQgcV9j
bWRfY291bnQ7Cj4gwqDCoMKgwqDCoMKgwqDCoHUzMiBkcmlkeDsKPiArwqDCoMKgwqDCoMKgwqB1
MzIgdGFpbF93aTsKPiDCoMKgwqDCoMKgwqDCoMKgdTMyIGlkOwo+IMKgfTsKPiDCoAo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2RtYS9hbWQvcHRkbWEvcHRkbWEtZG1hZW5naW5lLmMKPiBiL2RyaXZl
cnMvZG1hL2FtZC9wdGRtYS9wdGRtYS1kbWFlbmdpbmUuYwo+IGluZGV4IDkwY2EwMmZkNWY4Zi4u
MWYwMjBmOTBkODg2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZG1hL2FtZC9wdGRtYS9wdGRtYS1k
bWFlbmdpbmUuYwo+ICsrKyBiL2RyaXZlcnMvZG1hL2FtZC9wdGRtYS9wdGRtYS1kbWFlbmdpbmUu
Ywo+IEBAIC00NjIsNiArNDYyLDcgQEAgaW50IHB0X2RtYWVuZ2luZV9yZWdpc3RlcihzdHJ1Y3Qg
cHRfZGV2aWNlICpwdCkKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+IMKgfQo+
ICtFWFBPUlRfU1lNQk9MX0dQTChwdF9kbWFlbmdpbmVfcmVnaXN0ZXIpOwo+IMKgCj4gwqB2b2lk
IHB0X2RtYWVuZ2luZV91bnJlZ2lzdGVyKHN0cnVjdCBwdF9kZXZpY2UgKnB0KQo+IMKgewoK


