Return-Path: <dmaengine+bounces-2523-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABE091448A
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 10:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCEA1C2115B
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE97145007;
	Mon, 24 Jun 2024 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQqPCjrs"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ECB4AECE
	for <dmaengine@vger.kernel.org>; Mon, 24 Jun 2024 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217241; cv=none; b=u75H19yhYK5/1GJg0zXE08fThYcBV6KJ2o2/W65g+SpZ2FbEAA5js5aRohIQNv4yOExBhJIu8rRvxH8lI8LiWYRM0SRIMn59QBEVZS50Gx7jI/295VAC/O4bvXqWpPrHmNfDUGjf4xGRlJNGyPKpYHUCcKocH3zFllrQrrwMxWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217241; c=relaxed/simple;
	bh=ZO+z0BarzVNvDZMQ3KAbc8WUKqI4wvb8ivdNIqDedW4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pP+yMR6fqkybLFyZsveQWHQ+y7NYx6jpDcumTN48LEMy0UDCqW9tJRqCy9JcqAR6pFLKgQhMLmXp2PsfW6i6bRM381G8Ak+fnE9e8eFLRBMycohkST/tEYPtu/SfkvSac/BrST2cRkZJmtQJeS5feDxtJCRHejYkaUN4LGGQ5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQqPCjrs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719217238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZO+z0BarzVNvDZMQ3KAbc8WUKqI4wvb8ivdNIqDedW4=;
	b=XQqPCjrsDtMW0rium73r0CnLLAJoDgvQ2c2goqfs1t0t7ebRvtmYpXB+x7GRMoluaohjH9
	VKQgAACFkT1DjYL0c38XNT3yOZQlXFVH8bSHVpV1shkiWYq5wkHIA1P0TbC9fymvqc9b9E
	KUWuV0CHlraLL2Q2rwC1Mr87E1dbhf4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-O0Zp9DmtPAKzfaZ1jfgTcQ-1; Mon, 24 Jun 2024 04:20:34 -0400
X-MC-Unique: O0Zp9DmtPAKzfaZ1jfgTcQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42282eb67dcso5796665e9.3
        for <dmaengine@vger.kernel.org>; Mon, 24 Jun 2024 01:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719217233; x=1719822033;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZO+z0BarzVNvDZMQ3KAbc8WUKqI4wvb8ivdNIqDedW4=;
        b=Gf6E47T4tR8fVFB4HakIs8ueA1hsJLIesN4HxrYBtTXE/u/C81FYRqtadyJNgppDXZ
         KxDke90A9z3XpMiNow6loNkKGlQB67r3h1pVue6iJQP6QGZ+f3pxgHc9UImkJblq7OFe
         5p3s0vx5lJWhf/JcmBPE/Bb/qIpqEFwj6wHC6RDy7szODSRl3Nql6y/64D6fxvwanJg3
         KkCoIfZJhMKdhovOGTOY67vWP0dFdl5PvxZqJWUqNnNHWmOp54bPZTRYP5oCgUgsuN+4
         tA6ml1U1N/9WrPtjX03d5Tfpdww2h5JVDmczzWKl2jmqu8+K2nz7ezFcQAemwG64URPG
         cX5w==
X-Forwarded-Encrypted: i=1; AJvYcCXyx98yWfjbEuWV1CiNS3N5huJeifK2OL9SQzW5RTrDmjw1b5MAP7q7uqjQ9lkxx+mcq2bBTg8LhK8hHbkIIydm3Rd2Zg0+Bz7F
X-Gm-Message-State: AOJu0YyN81NECeXVrbtJ6i7dmIwgBMFjs303OVPpqh0ttCobiCLwf1j2
	Yp+kn7XTWFhoQEnddE3r467kGphO9Z4wGAoV/IHgyWhNtFNVvDyLN7LqyomcUyzOvBSmk4A/OUP
	pF16fStXyZ+/K2CiGjDLzToGJQt2/Zec/LYHxEqzwPgpjnPhv7PSR/EBuSw==
X-Received: by 2002:a05:6000:1a8b:b0:35f:2f97:e890 with SMTP id ffacd0b85a97d-366df681ef6mr4076668f8f.0.1719217232775;
        Mon, 24 Jun 2024 01:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfvUXPbjfpuH1vUzZxmbr4VVvzWSF5DLpiQwT8sGRTp2lSDdgmVxg/WoRZ4O7Avu7wg4QIog==
X-Received: by 2002:a05:6000:1a8b:b0:35f:2f97:e890 with SMTP id ffacd0b85a97d-366df681ef6mr4076649f8f.0.1719217232248;
        Mon, 24 Jun 2024 01:20:32 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638e90cbesm9336674f8f.58.2024.06.24.01.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:20:31 -0700 (PDT)
Message-ID: <5662c418bef136e7ba9ed5aaae8d6d8f3bf67d2d.camel@redhat.com>
Subject: Re: [PATCH v3 2/7] dmaengine: ae4dma: Add AMD ae4dma controller
 driver
From: Philipp Stanner <pstanner@redhat.com>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, vkoul@kernel.org, 
	dmaengine@vger.kernel.org
Cc: Raju.Rangoju@amd.com, Frank.li@nxp.com, helgaas@kernel.org
Date: Mon, 24 Jun 2024 10:20:30 +0200
In-Reply-To: <20240624075610.1659502-3-Basavaraj.Natikar@amd.com>
References: <20240624075610.1659502-1-Basavaraj.Natikar@amd.com>
	 <20240624075610.1659502-3-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGksCgp0aHggZm9yIHJld29ya2luZyB0aGUgbWVtb3J5IG9yZGVyaW5nLgoKSSBqdXN0IGZvdW5k
IGZldyBtb3JlIG5pdHM6CgpPbiBNb24sIDIwMjQtMDYtMjQgYXQgMTM6MjYgKzA1MzAsIEJhc2F2
YXJhaiBOYXRpa2FyIHdyb3RlOgo+IEFkZCBzdXBwb3J0IGZvciBBTUQgQUU0RE1BIGNvbnRyb2xs
ZXIuIEl0IHBlcmZvcm1zIGhpZ2gtYmFuZHdpZHRoCj4gbWVtb3J5IHRvIG1lbW9yeSBhbmQgSU8g
Y29weSBvcGVyYXRpb24uIERldmljZSBjb21tYW5kcyBhcmUgbWFuYWdlZAo+IHZpYSBhIGNpcmN1
bGFyIHF1ZXVlIG9mICdkZXNjcmlwdG9ycycsIGVhY2ggb2Ygd2hpY2ggc3BlY2lmaWVzIHNvdXJj
ZQo+IGFuZCBkZXN0aW5hdGlvbiBhZGRyZXNzZXMgZm9yIGNvcHlpbmcgYSBzaW5nbGUgYnVmZmVy
IG9mIGRhdGEuCj4gCj4gUmV2aWV3ZWQtYnk6IFJhanUgUmFuZ29qdSA8UmFqdS5SYW5nb2p1QGFt
ZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQmFzYXZhcmFqIE5hdGlrYXIgPEJhc2F2YXJhai5OYXRp
a2FyQGFtZC5jb20+Cj4gLS0tCj4gwqBNQUlOVEFJTkVSU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA2ICsKPiDCoGRyaXZlcnMvZG1hL2FtZC9L
Y29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+IMKgZHJpdmVycy9kbWEv
YW1kL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsKPiDCoGRyaXZlcnMv
ZG1hL2FtZC9hZTRkbWEvS2NvbmZpZ8KgwqDCoMKgwqAgfMKgIDE0ICsrCj4gwqBkcml2ZXJzL2Rt
YS9hbWQvYWU0ZG1hL01ha2VmaWxlwqDCoMKgwqAgfMKgIDEwICsrCj4gwqBkcml2ZXJzL2RtYS9h
bWQvYWU0ZG1hL2FlNGRtYS1kZXYuYyB8IDIwMAo+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysKPiDCoGRyaXZlcnMvZG1hL2FtZC9hZTRkbWEvYWU0ZG1hLXBjaS5jIHwgMTU3ICsrKysrKysr
KysrKysrKysrKysrKysKPiDCoGRyaXZlcnMvZG1hL2FtZC9hZTRkbWEvYWU0ZG1hLmjCoMKgwqDC
oCB8wqAgNzcgKysrKysrKysrKysKPiDCoGRyaXZlcnMvZG1hL2FtZC9jb21tb24vYW1kX2RtYS5o
wqDCoMKgIHzCoCAyNiArKysrCj4gwqA5IGZpbGVzIGNoYW5nZWQsIDQ5MiBpbnNlcnRpb25zKCsp
Cj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9kbWEvYW1kL2FlNGRtYS9LY29uZmlnCj4g
wqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9kbWEvYW1kL2FlNGRtYS9NYWtlZmlsZQo+IMKg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZG1hL2FtZC9hZTRkbWEvYWU0ZG1hLWRldi5jCj4g
wqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9kbWEvYW1kL2FlNGRtYS9hZTRkbWEtcGNpLmMK
PiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2RtYS9hbWQvYWU0ZG1hL2FlNGRtYS5oCj4g
wqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9kbWEvYW1kL2NvbW1vbi9hbWRfZG1hLmgKPiAK
PiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUwo+IGluZGV4IDUzNzk2NGFm
ZWY1NS4uNDI0MzZlMWNmMWUyIDEwMDY0NAo+IC0tLSBhL01BSU5UQUlORVJTCj4gKysrIGIvTUFJ
TlRBSU5FUlMKPiBAQCAtOTQ3LDYgKzk0NywxMiBAQCBMOsKgbGludXgtZWRhY0B2Z2VyLmtlcm5l
bC5vcmcKPiDCoFM6wqDCoMKgwqDCoFN1cHBvcnRlZAo+IMKgRjrCoMKgwqDCoMKgZHJpdmVycy9y
YXMvYW1kL2F0bC8qCj4gwqAKPiArQU1EIEFFNERNQSBEUklWRVIKPiArTTrCoMKgwqDCoMKgQmFz
YXZhcmFqIE5hdGlrYXIgPEJhc2F2YXJhai5OYXRpa2FyQGFtZC5jb20+Cj4gK0w6wqDCoMKgwqDC
oGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmcKPiArUzrCoMKgwqDCoMKgTWFpbnRhaW5lZAo+ICtG
OsKgwqDCoMKgwqBkcml2ZXJzL2RtYS9hbWQvYWU0ZG1hLwo+ICsKPiDCoEFNRCBBWEkgVzEgRFJJ
VkVSCj4gwqBNOsKgwqDCoMKgwqBLcmlzIENoYXBsaW4gPGtyaXMuY2hhcGxpbkBhbWQuY29tPgo+
IMKgUjrCoMKgwqDCoMKgVGhvbWFzIERlbGV2IDx0aG9tYXMuZGVsZXZAYW1kLmNvbT4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9kbWEvYW1kL0tjb25maWcgYi9kcml2ZXJzL2RtYS9hbWQvS2NvbmZp
Zwo+IGluZGV4IDgyNDZiNDYzYmNmNy4uOGMyNWEzZWQ2Yjk0IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZG1hL2FtZC9LY29uZmlnCj4gKysrIGIvZHJpdmVycy9kbWEvYW1kL0tjb25maWcKPiBAQCAt
MywzICszLDQgQEAKPiDCoCMgQU1EIERNQSBEcml2ZXJzCj4gwqAKPiDCoHNvdXJjZSAiZHJpdmVy
cy9kbWEvYW1kL3B0ZG1hL0tjb25maWciCj4gK3NvdXJjZSAiZHJpdmVycy9kbWEvYW1kL2FlNGRt
YS9LY29uZmlnIgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9hbWQvTWFrZWZpbGUgYi9kcml2
ZXJzL2RtYS9hbWQvTWFrZWZpbGUKPiBpbmRleCBkZDcyNTdiYTdlMDYuLjgwNDliMDZhOWZmNSAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2RtYS9hbWQvTWFrZWZpbGUKPiArKysgYi9kcml2ZXJzL2Rt
YS9hbWQvTWFrZWZpbGUKPiBAQCAtNCwzICs0LDQgQEAKPiDCoCMKPiDCoAo+IMKgb2JqLSQoQ09O
RklHX0FNRF9QVERNQSkgKz0gcHRkbWEvCj4gK29iai0kKENPTkZJR19BTURfQUU0RE1BKSArPSBh
ZTRkbWEvCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2FtZC9hZTRkbWEvS2NvbmZpZwo+IGIv
ZHJpdmVycy9kbWEvYW1kL2FlNGRtYS9LY29uZmlnCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBp
bmRleCAwMDAwMDAwMDAwMDAuLmVhOGE3ZmU2OGRmNQo+IC0tLSAvZGV2L251bGwKPiArKysgYi9k
cml2ZXJzL2RtYS9hbWQvYWU0ZG1hL0tjb25maWcKPiBAQCAtMCwwICsxLDE0IEBACj4gKyMgU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPiArY29uZmlnIEFNRF9BRTRETUEKPiArwqDC
oMKgwqDCoMKgwqB0cmlzdGF0ZcKgICJBTUQgQUU0RE1BIEVuZ2luZSIKPiArwqDCoMKgwqDCoMKg
wqBkZXBlbmRzIG9uIChYODZfNjQgfHwgQ09NUElMRV9URVNUKSAmJiBQQ0kKPiArwqDCoMKgwqDC
oMKgwqBkZXBlbmRzIG9uIEFNRF9QVERNQQo+ICvCoMKgwqDCoMKgwqDCoHNlbGVjdCBETUFfRU5H
SU5FCj4gK8KgwqDCoMKgwqDCoMKgc2VsZWN0IERNQV9WSVJUVUFMX0NIQU5ORUxTCj4gK8KgwqDC
oMKgwqDCoMKgaGVscAo+ICvCoMKgwqDCoMKgwqDCoMKgIEVuYWJsZSBzdXBwb3J0IGZvciB0aGUg
QU1EIEFFNERNQSBjb250cm9sbGVyLiBUaGlzCj4gY29udHJvbGxlcgo+ICvCoMKgwqDCoMKgwqDC
oMKgIHByb3ZpZGVzIERNQSBjYXBhYmlsaXRpZXMgdG8gcGVyZm9ybSBoaWdoIGJhbmR3aWR0aCBt
ZW1vcnkKPiB0bwo+ICvCoMKgwqDCoMKgwqDCoMKgIG1lbW9yeSBhbmQgSU8gY29weSBvcGVyYXRp
b25zLiBJdCBwZXJmb3JtcyBETUEgdHJhbnNmZXIKPiB0aHJvdWdoCj4gK8KgwqDCoMKgwqDCoMKg
wqAgcXVldWUtYmFzZWQgZGVzY3JpcHRvciBtYW5hZ2VtZW50LiBUaGlzIERNQSBjb250cm9sbGVy
IGlzCj4gaW50ZW5kZWQKPiArwqDCoMKgwqDCoMKgwqDCoCB0byBiZSB1c2VkIHdpdGggQU1EIE5v
bi1UcmFuc3BhcmVudCBCcmlkZ2UgZGV2aWNlcyBhbmQgbm90Cj4gZm9yCj4gK8KgwqDCoMKgwqDC
oMKgwqAgZ2VuZXJhbCBwdXJwb3NlIHBlcmlwaGVyYWwgRE1BLgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2RtYS9hbWQvYWU0ZG1hL01ha2VmaWxlCj4gYi9kcml2ZXJzL2RtYS9hbWQvYWU0ZG1hL01h
a2VmaWxlCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAwMDAuLmU5MThm
ODVhODBlYwo+IC0tLSAvZGV2L251bGwKPiArKysgYi9kcml2ZXJzL2RtYS9hbWQvYWU0ZG1hL01h
a2VmaWxlCj4gQEAgLTAsMCArMSwxMCBAQAo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wCj4gKyMKPiArIyBBTUQgQUU0RE1BIGRyaXZlcgo+ICsjCj4gKwo+ICtvYmotJChDT05G
SUdfQU1EX0FFNERNQSkgKz0gYWU0ZG1hLm8KPiArCj4gK2FlNGRtYS1vYmpzIDo9IGFlNGRtYS1k
ZXYubwo+ICsKPiArYWU0ZG1hLSQoQ09ORklHX1BDSSkgKz0gYWU0ZG1hLXBjaS5vCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZG1hL2FtZC9hZTRkbWEvYWU0ZG1hLWRldi5jCj4gYi9kcml2ZXJzL2Rt
YS9hbWQvYWU0ZG1hL2FlNGRtYS1kZXYuYwo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi5jYjA1ZmNiNDc5ODcKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvZHJpdmVy
cy9kbWEvYW1kL2FlNGRtYS9hZTRkbWEtZGV2LmMKPiBAQCAtMCwwICsxLDIwMCBAQAo+ICsvLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAo+ICsvKgo+ICsgKiBBTUQgQUU0RE1BIGRy
aXZlcgo+ICsgKgo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjQsIEFkdmFuY2VkIE1pY3JvIERldmlj
ZXMsIEluYy4KPiArICogQWxsIFJpZ2h0cyBSZXNlcnZlZC4KPiArICoKPiArICogQXV0aG9yOiBC
YXNhdmFyYWogTmF0aWthciA8QmFzYXZhcmFqLk5hdGlrYXJAYW1kLmNvbT4KPiArICovCj4gKwo+
ICsjaW5jbHVkZSAiYWU0ZG1hLmgiCj4gKwo+ICtzdGF0aWMgdW5zaWduZWQgaW50IG1heF9od19x
ID0gMTsKPiArbW9kdWxlX3BhcmFtKG1heF9od19xLCB1aW50LCAwNDQ0KTsKPiArTU9EVUxFX1BB
Uk1fREVTQyhtYXhfaHdfcSwgIm1heCBodyBxdWV1ZXMgc3VwcG9ydGVkIGJ5IGVuZ2luZSAoYW55
Cj4gbm9uLXplcm8gdmFsdWUsIGRlZmF1bHQ6IDEpIik7Cj4gKwo+ICtzdGF0aWMgY2hhciAqYWU0
X2Vycm9yX2NvZGVzW10gPSB7Cj4gK8KgwqDCoMKgwqDCoMKgIiIsCj4gK8KgwqDCoMKgwqDCoMKg
IkVSUiAwMTogSU5WQUxJRCBIRUFERVIgRFcwIiwKPiArwqDCoMKgwqDCoMKgwqAiRVJSIDAyOiBJ
TlZBTElEIFNUQVRVUyIsCj4gK8KgwqDCoMKgwqDCoMKgIkVSUiAwMzogSU5WQUxJRCBMRU5HVEgg
LSA0IEJZVEUgQUxJR05NRU5UIiwKPiArwqDCoMKgwqDCoMKgwqAiRVJSIDA0OiBJTlZBTElEIFNS
QyBBRERSIC0gNCBCWVRFIEFMSUdOTUVOVCIsCj4gK8KgwqDCoMKgwqDCoMKgIkVSUiAwNTogSU5W
QUxJRCBEU1QgQUREUiAtIDQgQllURSBBTElHTk1FTlQiLAo+ICvCoMKgwqDCoMKgwqDCoCJFUlIg
MDY6IElOVkFMSUQgQUxJR05NRU5UIiwKPiArwqDCoMKgwqDCoMKgwqAiRVJSIDA3OiBJTlZBTElE
IERFU0NSSVBUT1IiLAo+ICt9Owo+ICsKPiArc3RhdGljIHZvaWQgYWU0X2xvZ19lcnJvcihzdHJ1
Y3QgcHRfZGV2aWNlICpkLCBpbnQgZSkKPiArewo+ICvCoMKgwqDCoMKgwqDCoGlmIChlIDw9IDcp
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9pbmZvKGQtPmRldiwgIkFFNERN
QSBlcnJvcjogJXMgKDB4JXgpXG4iLAo+IGFlNF9lcnJvcl9jb2Rlc1tlXSwgZSk7Cj4gK8KgwqDC
oMKgwqDCoMKgZWxzZSBpZiAoZSA+IDcgJiYgZSA8PSAxNSkKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZGV2X2luZm8oZC0+ZGV2LCAiQUU0RE1BIGVycm9yOiAlcyAoMHgleClcbiIs
Cj4gIklOVkFMSUQgREVTQ1JJUFRPUiIsIGUpOwo+ICvCoMKgwqDCoMKgwqDCoGVsc2UgaWYgKGUg
PiAxNSAmJiBlIDw9IDMxKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfaW5m
byhkLT5kZXYsICJBRTRETUEgZXJyb3I6ICVzICgweCV4KVxuIiwKPiAiSU5WQUxJRCBERVNDUklQ
VE9SIiwgZSk7Cj4gK8KgwqDCoMKgwqDCoMKgZWxzZSBpZiAoZSA+IDMxICYmIGUgPD0gNjMpCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9pbmZvKGQtPmRldiwgIkFFNERNQSBl
cnJvcjogJXMgKDB4JXgpXG4iLAo+ICJJTlZBTElEIERFU0NSSVBUT1IiLCBlKTsKPiArwqDCoMKg
wqDCoMKgwqBlbHNlIGlmIChlID4gNjMgJiYgZSA8PSAxMjcpCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGRldl9pbmZvKGQtPmRldiwgIkFFNERNQSBlcnJvcjogJXMgKDB4JXgpXG4i
LCAiUFRFCj4gRVJST1IiLCBlKTsKPiArwqDCoMKgwqDCoMKgwqBlbHNlIGlmIChlID4gMTI3ICYm
IGUgPD0gMjU1KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfaW5mbyhkLT5k
ZXYsICJBRTRETUEgZXJyb3I6ICVzICgweCV4KVxuIiwgIlBURQo+IEVSUk9SIiwgZSk7CgpUaG9z
ZSBudW1iZXJzIGFyZSBoYXJkd2FyZS1zcGVjaWZpYyBJIGd1ZXNzPyBXb3VsZCBpdCBtYWtlIHNl
bnNlIHRvCmRlZmluZSBjb25zdGFudHMgZm9yIHRoZW0/IE9yIGhhdmUgYSBzaG9ydCBjb21tZW50
IHdoZXJlIHRoZXkgY29tZQpmcm9tPwoKPiArwqDCoMKgwqDCoMKgwqBlbHNlCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9pbmZvKGQtPmRldiwgIlVua25vd24gQUU0RE1BIGVy
cm9yIik7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIGFlNF9jaGVja19zdGF0dXNfZXJyb3Ioc3Ry
dWN0IGFlNF9jbWRfcXVldWUgKmFlNGNtZF9xLAo+IGludCBpZHgpCj4gK3sKPiArwqDCoMKgwqDC
oMKgwqBzdHJ1Y3QgcHRfY21kX3F1ZXVlICpjbWRfcSA9ICZhZTRjbWRfcS0+Y21kX3E7Cj4gK8Kg
wqDCoMKgwqDCoMKgc3RydWN0IGFlNGRtYV9kZXNjIGRlc2M7Cj4gK8KgwqDCoMKgwqDCoMKgdTgg
c3RhdHVzOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBtZW1jcHkoJmRlc2MsICZjbWRfcS0+cWJhc2Vb
aWR4XSwgc2l6ZW9mKHN0cnVjdAo+IGFlNGRtYV9kZXNjKSk7Cj4gK8KgwqDCoMKgwqDCoMKgc3Rh
dHVzID0gZGVzYy5kdzEuc3RhdHVzOwo+ICvCoMKgwqDCoMKgwqDCoGlmIChzdGF0dXMgJiYgc3Rh
dHVzICE9IEFFNF9ERVNDX0NPTVBMRVRFRCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBjbWRfcS0+Y21kX2Vycm9yID0gZGVzYy5kdzEuZXJyX2NvZGU7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGlmIChjbWRfcS0+Y21kX2Vycm9yKQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWU0X2xvZ19lcnJvcihjbWRfcS0+cHQs
IGNtZF9xLT5jbWRfZXJyb3IpOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiArfQo+ICsKPiArc3RhdGlj
IHZvaWQgYWU0X3BlbmRpbmdfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4gK3sKPiAr
wqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWU0X2NtZF9xdWV1ZSAqYWU0Y21kX3EgPSBjb250YWluZXJf
b2Yod29yaywgc3RydWN0Cj4gYWU0X2NtZF9xdWV1ZSwgcF93b3JrLndvcmspOwo+ICvCoMKgwqDC
oMKgwqDCoHN0cnVjdCBwdF9jbWRfcXVldWUgKmNtZF9xID0gJmFlNGNtZF9xLT5jbWRfcTsKPiAr
wqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcHRfY21kICpjbWQ7Cj4gK8KgwqDCoMKgwqDCoMKgdTMyIGNy
aWR4Owo+ICsKPiArwqDCoMKgwqDCoMKgwqB3aGlsZSAodHJ1ZSkgewoKTml0OiBJIHRoaW5rCgpm
b3IgKDs7KSB7CgppcyBtb3JlIGlkaW9tYXRpYyBpbiB0aGUga2VybmVsCgo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB3YWl0X2V2ZW50X2ludGVycnVwdGlibGUoYWU0Y21kX3EtPnFf
dywKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgoYXRvbWljNjRfcmVhZCgmYWU0Y21kX3EtCj4g
PmRvbmVfY250KSkgPAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGF0b21pYzY0X3JlYWQo
JmFlNGNtZF9xLQo+ID5pbnRyX2NudCkpKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGF0b21pYzY0X2luYygmYWU0Y21kX3EtPmRvbmVfY250KTsKPiArCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoG11dGV4X2xvY2soJmFlNGNtZF9xLT5jbWRfbG9jayk7Cj4g
Kwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjcmlkeCA9IHJlYWRsKGNtZF9xLT5y
ZWdfY29udHJvbCArIDB4MEMpOwoKTWFnaWMgbnVtYmVyIDB4MEMg4oCTIHdoYXQgZG9lcyBpdCBt
ZWFuPyBJJ2QgZGVmaW5lIGEgY29uc3RhbnQuCgo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgd2hpbGUgKChhZTRjbWRfcS0+ZHJpZHggIT0gY3JpZHgpICYmCj4gIWxpc3RfZW1w
dHkoJmFlNGNtZF9xLT5jbWQpKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBjbWQgPSBsaXN0X2ZpcnN0X2VudHJ5KCZhZTRjbWRfcS0+Y21kLCBzdHJ1
Y3QKPiBwdF9jbWQsIGVudHJ5KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGxpc3RfZGVsKCZjbWQtPmVudHJ5KTsKPiArCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhZTRfY2hlY2tfc3RhdHVzX2Vycm9yKGFl
NGNtZF9xLCBhZTRjbWRfcS0KPiA+ZHJpZHgpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgY21kLT5wdF9jbWRfY2FsbGJhY2soY21kLT5kYXRhLCBjbWQt
PnJldCk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgYWU0Y21kX3EtPnFfY21kX2NvdW50LS07Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBhZTRjbWRfcS0+ZHJpZHggPSAoYWU0Y21kX3EtPmRyaWR4ICsg
MSkgJQo+IENNRF9RX0xFTjsKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBjb21wbGV0ZV9hbGwoJmFlNGNtZF9xLT5jbXApOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBtdXRleF91bmxvY2soJmFlNGNtZF9xLT5jbWRfbG9jayk7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+
ICt9Cj4gKwo+ICtzdGF0aWMgaXJxcmV0dXJuX3QgYWU0X2NvcmVfaXJxX2hhbmRsZXIoaW50IGly
cSwgdm9pZCAqZGF0YSkKPiArewo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBhZTRfY21kX3F1ZXVl
ICphZTRjbWRfcSA9IGRhdGE7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHB0X2NtZF9xdWV1ZSAq
Y21kX3E7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHB0X2RldmljZSAqcHQ7Cj4gK8KgwqDCoMKg
wqDCoMKgdTMyIHN0YXR1czsKPiArCj4gK8KgwqDCoMKgwqDCoMKgY21kX3EgPSAmYWU0Y21kX3Et
PmNtZF9xOwo+ICvCoMKgwqDCoMKgwqDCoHB0ID0gY21kX3EtPnB0Owo+ICsKPiArwqDCoMKgwqDC
oMKgwqBwdC0+dG90YWxfaW50ZXJydXB0cysrOwo+ICvCoMKgwqDCoMKgwqDCoGF0b21pYzY0X2lu
YygmYWU0Y21kX3EtPmludHJfY250KTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgd2FrZV91cCgmYWU0
Y21kX3EtPnFfdyk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHN0YXR1cyA9IHJlYWRsKGNtZF9xLT5y
ZWdfY29udHJvbCArIDB4MTQpOwo+ICvCoMKgwqDCoMKgwqDCoGlmIChzdGF0dXMgJiBCSVQoMCkp
IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RhdHVzICY9IEdFTk1BU0soMzEs
IDEpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB3cml0ZWwoc3RhdHVzLCBjbWRf
cS0+cmVnX2NvbnRyb2wgKyAweDE0KTsKCnNhbWUgd2l0aCAweDE0Cgo+ICvCoMKgwqDCoMKgwqDC
oH0KPiArCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIElSUV9IQU5ETEVEOwo+ICt9Cj4gKwo+ICt2
b2lkIGFlNF9kZXN0cm95X3dvcmsoc3RydWN0IGFlNF9kZXZpY2UgKmFlNCkKPiArewo+ICvCoMKg
wqDCoMKgwqDCoHN0cnVjdCBhZTRfY21kX3F1ZXVlICphZTRjbWRfcTsKPiArwqDCoMKgwqDCoMKg
wqBpbnQgaTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgZm9yIChpID0gMDsgaSA8IGFlNC0+Y21kX3Ff
Y291bnQ7IGkrKykgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhZTRjbWRfcSA9
ICZhZTQtPmFlNGNtZF9xW2ldOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aWYgKCFhZTRjbWRfcS0+cHdzKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgYnJlYWs7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBj
YW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFlNGNtZF9xLT5wX3dvcmspOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBkZXN0cm95X3dvcmtxdWV1ZShhZTRjbWRfcS0+cHdzKTsKPiAr
wqDCoMKgwqDCoMKgwqB9Cj4gK30KPiArCj4gK2ludCBhZTRfY29yZV9pbml0KHN0cnVjdCBhZTRf
ZGV2aWNlICphZTQpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcHRfZGV2aWNlICpwdCA9
ICZhZTQtPnB0Owo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBhZTRfY21kX3F1ZXVlICphZTRjbWRf
cTsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwdC0+ZGV2Owo+ICvCoMKg
wqDCoMKgwqDCoHN0cnVjdCBwdF9jbWRfcXVldWUgKmNtZF9xOwo+ICvCoMKgwqDCoMKgwqDCoGlu
dCBpLCByZXQgPSAwOwo+ICsKPiArwqDCoMKgwqDCoMKgwqB3cml0ZWwobWF4X2h3X3EsIHB0LT5p
b19yZWdzKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgZm9yIChpID0gMDsgaSA8IG1heF9od19xOyBp
KyspIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWU0Y21kX3EgPSAmYWU0LT5h
ZTRjbWRfcVtpXTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWU0Y21kX3EtPmlk
ID0gYWU0LT5jbWRfcV9jb3VudDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWU0
LT5jbWRfcV9jb3VudCsrOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY21k
X3EgPSAmYWU0Y21kX3EtPmNtZF9xOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBj
bWRfcS0+cHQgPSBwdDsKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIFBy
ZXNldCBzb21lIHJlZ2lzdGVyIHZhbHVlcyAoUSBzaXplIGlzIDMyYnl0ZQo+ICgweDIwKSkgKi8K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY21kX3EtPnJlZ19jb250cm9sID0gcHQt
PmlvX3JlZ3MgKyAoKGkgKyAxKSAqIDB4MjApOwoKT0ssIGhlcmUncyBhIGNvbW1lbnQuIENvdWxk
IHRoaW5rIGFib3V0IGRvaW5nOgoKI2RlZmluZSBRX1NJWkUgMHgyMAoKPiArCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IGRldm1fcmVxdWVzdF9pcnEoZGV2LCBhZTQtPmFl
NF9pcnFbaV0sCj4gYWU0X2NvcmVfaXJxX2hhbmRsZXIsIDAsCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGRldl9uYW1lKHB0LT5kZXYpLCBhZTRjbWRfcSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGlmIChyZXQpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gcmV0Owo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Y21kX3EtPnFzaXplID0gUV9TSVpFKHNpemVvZihzdHJ1Y3QgYWU0ZG1hX2Rlc2MpKTsKPiArCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNtZF9xLT5xYmFzZSA9IGRtYW1fYWxsb2Nf
Y29oZXJlbnQoZGV2LCBjbWRfcS0+cXNpemUsCj4gJmNtZF9xLT5xYmFzZV9kbWEsCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEdGUF9LRVJORUwpOwo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIWNtZF9xLT5xYmFzZSkKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5PTUVNOwo+ICvC
oMKgwqDCoMKgwqDCoH0KPiArCj4gK8KgwqDCoMKgwqDCoMKgZm9yIChpID0gMDsgaSA8IGFlNC0+
Y21kX3FfY291bnQ7IGkrKykgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhZTRj
bWRfcSA9ICZhZTQtPmFlNGNtZF9xW2ldOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgY21kX3EgPSAmYWU0Y21kX3EtPmNtZF9xOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgLyogUHJlc2V0IHNvbWUgcmVnaXN0ZXIgdmFsdWVzIChRIHNpemUgaXMgMzJi
eXRlCj4gKDB4MjApKSAqLwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjbWRfcS0+
cmVnX2NvbnRyb2wgPSBwdC0+aW9fcmVncyArICgoaSArIDEpICogMHgyMCk7CgpzYW1lCgo+ICsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogVXBkYXRlIHRoZSBkZXZpY2UgcmVn
aXN0ZXJzIHdpdGggcXVldWUKPiBpbmZvcm1hdGlvbi4gKi8KPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgd3JpdGVsKENNRF9RX0xFTiwgY21kX3EtPnJlZ19jb250cm9sICsgMHgwOCk7
CgpzYW1lCgo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY21kX3EtPnFkbWFf
dGFpbCA9IGNtZF9xLT5xYmFzZV9kbWE7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHdyaXRlbChsb3dlcl8zMl9iaXRzKGNtZF9xLT5xZG1hX3RhaWwpLCBjbWRfcS0KPiA+cmVnX2Nv
bnRyb2wgKyAweDE4KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgd3JpdGVsKHVw
cGVyXzMyX2JpdHMoY21kX3EtPnFkbWFfdGFpbCksIGNtZF9xLQo+ID5yZWdfY29udHJvbCArIDB4
MUMpOwoKc2FtZSB3aXRoIHRob3NlIHR3bwoKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoElOSVRfTElTVF9IRUFEKCZhZTRjbWRfcS0+Y21kKTsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaW5pdF93YWl0cXVldWVfaGVhZCgmYWU0Y21kX3EtPnFfdyk7Cj4gKwo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhZTRjbWRfcS0+cHdzID0gYWxsb2Nfb3Jk
ZXJlZF93b3JrcXVldWUoImFlNGRtYV8lZCIsCj4gV1FfTUVNX1JFQ0xBSU0sIGFlNGNtZF9xLT5p
ZCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghYWU0Y21kX3EtPnB3cykg
ewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWU0X2Rl
c3Ryb3lfd29yayhhZTQpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIC1FTk9NRU07Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oH0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgSU5JVF9ERUxBWUVEX1dPUksoJmFl
NGNtZF9xLT5wX3dvcmssCj4gYWU0X3BlbmRpbmdfd29yayk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHF1ZXVlX2RlbGF5ZWRfd29yayhhZTRjbWRfcS0+cHdzLCAmYWU0Y21kX3Et
PnBfd29yayzCoAo+IHVzZWNzX3RvX2ppZmZpZXMoMTAwKSk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBpbml0X2NvbXBsZXRpb24oJmFlNGNtZF9xLT5jbXApOwo+ICvCoMKg
wqDCoMKgwqDCoH0KPiArCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiArfQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2RtYS9hbWQvYWU0ZG1hL2FlNGRtYS1wY2kuYwo+IGIvZHJpdmVycy9k
bWEvYW1kL2FlNGRtYS9hZTRkbWEtcGNpLmMKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4
IDAwMDAwMDAwMDAwMC4uNDNkMzZlOWQxZWZiCj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL2RyaXZl
cnMvZG1hL2FtZC9hZTRkbWEvYWU0ZG1hLXBjaS5jCj4gQEAgLTAsMCArMSwxNTcgQEAKPiArLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPiArLyoKPiArICogQU1EIEFFNERNQSBk
cml2ZXIKPiArICoKPiArICogQ29weXJpZ2h0IChjKSAyMDI0LCBBZHZhbmNlZCBNaWNybyBEZXZp
Y2VzLCBJbmMuCj4gKyAqIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCj4gKyAqCj4gKyAqIEF1dGhvcjog
QmFzYXZhcmFqIE5hdGlrYXIgPEJhc2F2YXJhai5OYXRpa2FyQGFtZC5jb20+Cj4gKyAqLwo+ICsK
PiArI2luY2x1ZGUgImFlNGRtYS5oIgo+ICsKPiArc3RhdGljIGludCBhZTRfZ2V0X2lycXMoc3Ry
dWN0IGFlNF9kZXZpY2UgKmFlNCkKPiArewo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBhZTRfbXNp
eCAqYWU0X21zaXggPSBhZTQtPmFlNF9tc2l4Owo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBwdF9k
ZXZpY2UgKnB0ID0gJmFlNC0+cHQ7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGRldmljZSAqZGV2
ID0gcHQtPmRldjsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcGNpX2RldiAqcGRldjsKPiArwqDC
oMKgwqDCoMKgwqBpbnQgaSwgdiwgcmV0Owo+ICsKPiArwqDCoMKgwqDCoMKgwqBwZGV2ID0gdG9f
cGNpX2RldihkZXYpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBmb3IgKHYgPSAwOyB2IDwgQVJSQVlf
U0laRShhZTRfbXNpeC0+bXNpeF9lbnRyeSk7IHYrKykKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgYWU0X21zaXgtPm1zaXhfZW50cnlbdl0uZW50cnkgPSB2Owo+ICsKPiArwqDCoMKg
wqDCoMKgwqByZXQgPSBwY2lfYWxsb2NfaXJxX3ZlY3RvcnMocGRldiwgdiwgdiwgUENJX0lSUV9N
U0lYKTsKPiArwqDCoMKgwqDCoMKgwqBpZiAocmV0ICE9IHYpIHsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaWYgKHJldCA+IDApCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBwY2lfZnJlZV9pcnFfdmVjdG9ycyhwZGV2KTsKPiArCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9lcnIoZGV2LCAiY291bGQgbm90IGVuYWJs
ZSBNU0ktWCAoJWQpLCB0cnlpbmcKPiBNU0lcbiIsIHJldCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldCA9IHBjaV9hbGxvY19pcnFfdmVjdG9ycyhwZGV2LCAxLCAxLCBQQ0lf
SVJRX01TSSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQgPCAwKSB7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJy
KGRldiwgImNvdWxkIG5vdCBlbmFibGUgTVNJICglZClcbiIsCj4gcmV0KTsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldCA9IHBjaV9pcnFfdmVjdG9yKHBkZXYsIDApOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAocmV0IDwgMCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcGNpX2ZyZWVfaXJxX3ZlY3RvcnMocGRldik7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBmb3IgKGkgPSAwOyBpIDwgTUFYX0FFNF9IV19RVUVVRVM7IGkrKykKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFlNC0+YWU0X2lycVtp
XSA9IHJldDsKPiArCj4gK8KgwqDCoMKgwqDCoMKgfSBlbHNlIHsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgYWU0X21zaXgtPm1zaXhfY291bnQgPSByZXQ7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGZvciAoaSA9IDA7IGkgPCBNQVhfQUU0X0hXX1FVRVVFUzsgaSsr
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWU0LT5h
ZTRfaXJxW2ldID0gYWU0X21zaXgtCj4gPm1zaXhfZW50cnlbaV0udmVjdG9yOwo+ICvCoMKgwqDC
oMKgwqDCoH0KPiArCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiArfQo+ICsKPiArc3Rh
dGljIHZvaWQgYWU0X2ZyZWVfaXJxcyhzdHJ1Y3QgYWU0X2RldmljZSAqYWU0KQo+ICt7Cj4gK8Kg
wqDCoMKgwqDCoMKgc3RydWN0IGFlNF9tc2l4ICphZTRfbXNpeCA9IGFlNC0+YWU0X21zaXg7Cj4g
K8KgwqDCoMKgwqDCoMKgc3RydWN0IHB0X2RldmljZSAqcHQgPSAmYWU0LT5wdDsKPiArwqDCoMKg
wqDCoMKgwqBzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwdC0+ZGV2Owo+ICvCoMKgwqDCoMKgwqDCoHN0
cnVjdCBwY2lfZGV2ICpwZGV2Owo+ICsKPiArwqDCoMKgwqDCoMKgwqBwZGV2ID0gdG9fcGNpX2Rl
dihkZXYpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAoYWU0X21zaXggJiYgKGFlNF9tc2l4LT5t
c2l4X2NvdW50IHx8IGFlNC0KPiA+YWU0X2lycVtNQVhfQUU0X0hXX1FVRVVFUyAtIDFdKSkKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGNpX2ZyZWVfaXJxX3ZlY3RvcnMocGRldik7
Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIGFlNF9kZWluaXQoc3RydWN0IGFlNF9kZXZpY2UgKmFl
NCkKPiArewo+ICvCoMKgwqDCoMKgwqDCoGFlNF9mcmVlX2lycXMoYWU0KTsKPiArfQo+ICsKPiAr
c3RhdGljIGludCBhZTRfcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1
Y3QKPiBwY2lfZGV2aWNlX2lkICppZCkKPiArewo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBkZXZp
Y2UgKmRldiA9ICZwZGV2LT5kZXY7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGFlNF9kZXZpY2Ug
KmFlNDsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcHRfZGV2aWNlICpwdDsKPiArwqDCoMKgwqDC
oMKgwqBpbnQgYmFyX21hc2s7Cj4gK8KgwqDCoMKgwqDCoMKgaW50IHJldCA9IDA7Cj4gKwo+ICvC
oMKgwqDCoMKgwqDCoGFlNCA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqYWU0KSwgR0ZQX0tF
Uk5FTCk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFhZTQpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiAtRU5PTUVNOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBhZTQtPmFlNF9t
c2l4ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKHN0cnVjdCBhZTRfbXNpeCksCj4gR0ZQX0tF
Uk5FTCk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFhZTQtPmFlNF9tc2l4KQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT01FTTsKPiArCj4gK8KgwqDCoMKgwqDCoMKg
cmV0ID0gcGNpbV9lbmFibGVfZGV2aWNlKHBkZXYpOwo+ICvCoMKgwqDCoMKgwqDCoGlmIChyZXQp
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gYWU0X2Vycm9yOwo+ICsKPiAr
wqDCoMKgwqDCoMKgwqBiYXJfbWFzayA9IHBjaV9zZWxlY3RfYmFycyhwZGV2LCBJT1JFU09VUkNF
X01FTSk7Cj4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gcGNpbV9pb21hcF9yZWdpb25zKHBkZXYsIGJh
cl9tYXNrLCAiYWU0ZG1hIik7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBhZTRfZXJyb3I7Cj4gKwo+ICvCoMKgwqDCoMKgwqDC
oHB0ID0gJmFlNC0+cHQ7Cj4gK8KgwqDCoMKgwqDCoMKgcHQtPmRldiA9IGRldjsKPiArCj4gK8Kg
wqDCoMKgwqDCoMKgcHQtPmlvX3JlZ3MgPSBwY2ltX2lvbWFwX3RhYmxlKHBkZXYpWzBdOwo+ICvC
oMKgwqDCoMKgwqDCoGlmICghcHQtPmlvX3JlZ3MpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0ID0gLUVOT01FTTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Z290byBhZTRfZXJyb3I7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICsKPiArwqDCoMKgwqDCoMKgwqBy
ZXQgPSBhZTRfZ2V0X2lycXMoYWU0KTsKPiArwqDCoMKgwqDCoMKgwqBpZiAocmV0IDwgMCkKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBhZTRfZXJyb3I7Cj4gKwo+ICvCoMKg
wqDCoMKgwqDCoHBjaV9zZXRfbWFzdGVyKHBkZXYpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBkbWFf
c2V0X21hc2tfYW5kX2NvaGVyZW50KGRldiwgRE1BX0JJVF9NQVNLKDQ4KSk7Cj4gKwo+ICvCoMKg
wqDCoMKgwqDCoGRldl9zZXRfZHJ2ZGF0YShkZXYsIGFlNCk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDC
oHJldCA9IGFlNF9jb3JlX2luaXQoYWU0KTsKPiArwqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGFlNF9lcnJvcjsKPiArCj4gK8KgwqDC
oMKgwqDCoMKgcmV0dXJuIDA7Cj4gKwo+ICthZTRfZXJyb3I6Cj4gK8KgwqDCoMKgwqDCoMKgYWU0
X2RlaW5pdChhZTQpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+ICt9Cj4gKwo+
ICtzdGF0aWMgdm9pZCBhZTRfcGNpX3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikKPiArewo+
ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBhZTRfZGV2aWNlICphZTQgPSBkZXZfZ2V0X2RydmRhdGEo
JnBkZXYtPmRldik7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGFlNF9kZXN0cm95X3dvcmsoYWU0KTsK
PiArwqDCoMKgwqDCoMKgwqBhZTRfZGVpbml0KGFlNCk7Cj4gK30KPiArCj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBhZTRfcGNpX3RhYmxlW10gPSB7Cj4gK8KgwqDCoMKgwqDC
oMKgeyBQQ0lfVkRFVklDRShBTUQsIDB4MTRDOCksIH0sCj4gK8KgwqDCoMKgwqDCoMKgeyBQQ0lf
VkRFVklDRShBTUQsIDB4MTREQyksIH0sCj4gK8KgwqDCoMKgwqDCoMKgeyBQQ0lfVkRFVklDRShB
TUQsIDB4MTQ5QiksIH0sCj4gK8KgwqDCoMKgwqDCoMKgLyogTGFzdCBlbnRyeSBtdXN0IGJlIHpl
cm8gKi8KPiArwqDCoMKgwqDCoMKgwqB7IDAsIH0KPiArfTsKPiArTU9EVUxFX0RFVklDRV9UQUJM
RShwY2ksIGFlNF9wY2lfdGFibGUpOwo+ICsKPiArc3RhdGljIHN0cnVjdCBwY2lfZHJpdmVyIGFl
NF9wY2lfZHJpdmVyID0gewo+ICvCoMKgwqDCoMKgwqDCoC5uYW1lID0gImFlNGRtYSIsCj4gK8Kg
wqDCoMKgwqDCoMKgLmlkX3RhYmxlID0gYWU0X3BjaV90YWJsZSwKPiArwqDCoMKgwqDCoMKgwqAu
cHJvYmUgPSBhZTRfcGNpX3Byb2JlLAo+ICvCoMKgwqDCoMKgwqDCoC5yZW1vdmUgPSBhZTRfcGNp
X3JlbW92ZSwKPiArfTsKPiArCj4gK21vZHVsZV9wY2lfZHJpdmVyKGFlNF9wY2lfZHJpdmVyKTsK
PiArCj4gK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsKPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJBTUQg
QUU0RE1BIGRyaXZlciIpOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9hbWQvYWU0ZG1hL2Fl
NGRtYS5oCj4gYi9kcml2ZXJzL2RtYS9hbWQvYWU0ZG1hL2FlNGRtYS5oCj4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAwMDAuLjU5YTBlYTMyOTNjYgo+IC0tLSAvZGV2L251
bGwKPiArKysgYi9kcml2ZXJzL2RtYS9hbWQvYWU0ZG1hL2FlNGRtYS5oCj4gQEAgLTAsMCArMSw3
NyBAQAo+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLwo+ICsvKgo+ICsg
KiBBTUQgQUU0RE1BIGRyaXZlcgo+ICsgKgo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjQsIEFkdmFu
Y2VkIE1pY3JvIERldmljZXMsIEluYy4KPiArICogQWxsIFJpZ2h0cyBSZXNlcnZlZC4KPiArICoK
PiArICogQXV0aG9yOiBCYXNhdmFyYWogTmF0aWthciA8QmFzYXZhcmFqLk5hdGlrYXJAYW1kLmNv
bT4KPiArICovCj4gKyNpZm5kZWYgX19BRTRETUFfSF9fCj4gKyNkZWZpbmUgX19BRTRETUFfSF9f
Cj4gKwo+ICsjaW5jbHVkZSAiLi4vY29tbW9uL2FtZF9kbWEuaCIKPiArCj4gKyNkZWZpbmUgTUFY
X0FFNF9IV19RVUVVRVPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMTYKPiArCj4gKyNkZWZp
bmUgQUU0X0RFU0NfQ09NUExFVEVEwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAweDMKCkhlcmUg
eW91IGRlZmluZSBzb21lIDopCgoKVGhhbmtzLApQLgoKPiArCj4gK3N0cnVjdCBhZTRfbXNpeCB7
Cj4gK8KgwqDCoMKgwqDCoMKgaW50IG1zaXhfY291bnQ7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0
IG1zaXhfZW50cnkgbXNpeF9lbnRyeVtNQVhfQUU0X0hXX1FVRVVFU107Cj4gK307Cj4gKwo+ICtz
dHJ1Y3QgYWU0X2NtZF9xdWV1ZSB7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGFlNF9kZXZpY2Ug
KmFlNDsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcHRfY21kX3F1ZXVlIGNtZF9xOwo+ICvCoMKg
wqDCoMKgwqDCoHN0cnVjdCBsaXN0X2hlYWQgY21kOwo+ICvCoMKgwqDCoMKgwqDCoC8qIHByb3Rl
Y3QgY29tbWFuZCBvcGVyYXRpb25zICovCj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IG11dGV4IGNt
ZF9sb2NrOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBkZWxheWVkX3dvcmsgcF93b3JrOwo+ICvC
oMKgwqDCoMKgwqDCoHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICpwd3M7Cj4gK8KgwqDCoMKgwqDC
oMKgc3RydWN0IGNvbXBsZXRpb24gY21wOwo+ICvCoMKgwqDCoMKgwqDCoHdhaXRfcXVldWVfaGVh
ZF90IHFfdzsKPiArwqDCoMKgwqDCoMKgwqBhdG9taWM2NF90IGludHJfY250Owo+ICvCoMKgwqDC
oMKgwqDCoGF0b21pYzY0X3QgZG9uZV9jbnQ7Cj4gK8KgwqDCoMKgwqDCoMKgdTY0IHFfY21kX2Nv
dW50Owo+ICvCoMKgwqDCoMKgwqDCoHUzMiBkcmlkeDsKPiArwqDCoMKgwqDCoMKgwqB1MzIgaWQ7
Cj4gK307Cj4gKwo+ICt1bmlvbiBkd291IHsKPiArwqDCoMKgwqDCoMKgwqB1MzIgZHcwOwo+ICvC
oMKgwqDCoMKgwqDCoHN0cnVjdCBkd29yZDAgewo+ICvCoMKgwqDCoMKgwqDCoHU4wqDCoMKgwqDC
oMKgYnl0ZTA7Cj4gK8KgwqDCoMKgwqDCoMKgdTjCoMKgwqDCoMKgwqBieXRlMTsKPiArwqDCoMKg
wqDCoMKgwqB1MTbCoMKgwqDCoMKgdGltZXN0YW1wOwo+ICvCoMKgwqDCoMKgwqDCoH0gZHdzOwo+
ICt9Owo+ICsKPiArc3RydWN0IGR3b3JkMSB7Cj4gK8KgwqDCoMKgwqDCoMKgdTjCoMKgwqDCoMKg
wqBzdGF0dXM7Cj4gK8KgwqDCoMKgwqDCoMKgdTjCoMKgwqDCoMKgwqBlcnJfY29kZTsKPiArwqDC
oMKgwqDCoMKgwqB1MTbCoMKgwqDCoMKgZGVzY19pZDsKPiArfTsKPiArCj4gK3N0cnVjdCBhZTRk
bWFfZGVzYyB7Cj4gK8KgwqDCoMKgwqDCoMKgdW5pb24gZHdvdSBkd291djsKPiArwqDCoMKgwqDC
oMKgwqBzdHJ1Y3QgZHdvcmQxIGR3MTsKPiArwqDCoMKgwqDCoMKgwqB1MzIgbGVuZ3RoOwo+ICvC
oMKgwqDCoMKgwqDCoHUzMiByc3ZkOwo+ICvCoMKgwqDCoMKgwqDCoHUzMiBzcmNfaGk7Cj4gK8Kg
wqDCoMKgwqDCoMKgdTMyIHNyY19sbzsKPiArwqDCoMKgwqDCoMKgwqB1MzIgZHN0X2hpOwo+ICvC
oMKgwqDCoMKgwqDCoHUzMiBkc3RfbG87Cj4gK307Cj4gKwo+ICtzdHJ1Y3QgYWU0X2RldmljZSB7
Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHB0X2RldmljZSBwdDsKPiArwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgYWU0X21zaXggKmFlNF9tc2l4Owo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBhZTRfY21k
X3F1ZXVlIGFlNGNtZF9xW01BWF9BRTRfSFdfUVVFVUVTXTsKPiArwqDCoMKgwqDCoMKgwqB1bnNp
Z25lZCBpbnQgYWU0X2lycVtNQVhfQUU0X0hXX1FVRVVFU107Cj4gK8KgwqDCoMKgwqDCoMKgdW5z
aWduZWQgaW50IGNtZF9xX2NvdW50Owo+ICt9Owo+ICsKPiAraW50IGFlNF9jb3JlX2luaXQoc3Ry
dWN0IGFlNF9kZXZpY2UgKmFlNCk7Cj4gK3ZvaWQgYWU0X2Rlc3Ryb3lfd29yayhzdHJ1Y3QgYWU0
X2RldmljZSAqYWU0KTsKPiArI2VuZGlmCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2FtZC9j
b21tb24vYW1kX2RtYS5oCj4gYi9kcml2ZXJzL2RtYS9hbWQvY29tbW9uL2FtZF9kbWEuaAo+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAwMDAwLi5mOWYzOTZjZDQzNzEKPiAt
LS0gL2Rldi9udWxsCj4gKysrIGIvZHJpdmVycy9kbWEvYW1kL2NvbW1vbi9hbWRfZG1hLmgKPiBA
QCAtMCwwICsxLDI2IEBACj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICov
Cj4gKy8qCj4gKyAqIEFNRCBETUEgRHJpdmVyIGNvbW1vbgo+ICsgKgo+ICsgKiBDb3B5cmlnaHQg
KGMpIDIwMjQsIEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4KPiArICogQWxsIFJpZ2h0cyBS
ZXNlcnZlZC4KPiArICoKPiArICogQXV0aG9yOiBCYXNhdmFyYWogTmF0aWthciA8QmFzYXZhcmFq
Lk5hdGlrYXJAYW1kLmNvbT4KPiArICovCj4gKwo+ICsjaWZuZGVmIEFNRF9ETUFfSAo+ICsjZGVm
aW5lIEFNRF9ETUFfSAo+ICsKPiArI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPgo+ICsjaW5jbHVk
ZSA8bGludXgvZG1hZW5naW5lLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9kbWFwb29sLmg+Cj4gKyNp
bmNsdWRlIDxsaW51eC9saXN0Lmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9tdXRleC5oPgo+ICsjaW5j
bHVkZSA8bGludXgvcGNpLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPgo+ICsjaW5j
bHVkZSA8bGludXgvd2FpdC5oPgo+ICsKPiArI2luY2x1ZGUgIi4uL3B0ZG1hL3B0ZG1hLmgiCj4g
KyNpbmNsdWRlICIuLi8uLi92aXJ0LWRtYS5oIgo+ICsKPiArI2VuZGlmCgo=


