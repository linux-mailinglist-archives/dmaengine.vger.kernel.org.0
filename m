Return-Path: <dmaengine+bounces-2201-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 569918D32B2
	for <lists+dmaengine@lfdr.de>; Wed, 29 May 2024 11:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102AE282BFC
	for <lists+dmaengine@lfdr.de>; Wed, 29 May 2024 09:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0E36F079;
	Wed, 29 May 2024 09:15:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E16A381C8
	for <dmaengine@vger.kernel.org>; Wed, 29 May 2024 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974157; cv=none; b=otg/TD4YUEHTbx/yKHbAcFbKwrEsqKNFMZMs9KvSd/3TDfCtk9gPghNROFo+WQpOA8vzWO4AF9MSbFhwSyDUKf3WtTupUCZShqfXeFjMeoBTC1xmsa7xdRc+bUBmK5ywiIqmelpX7hFiBthjYp0opDGyw2A6CR8oIeAvILx74cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974157; c=relaxed/simple;
	bh=U2Zd6TNcYySCaBmWtA1My7XSFKCQ+aF6fiJnJL7Wypk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PPf4PC0epoloscSyN+aIh32dCI8Bvt/s0GVM/gkymsPblq9U1swIDCcGmj/ZJlqz58rbCMH6Dvp87xHtCZPnDFruyg7OwhMh93FufCGtHaMzZ5SgWgYS94kkM819rtlFRhmo9bHocjXq93KsxnPCyIyO7a2QLrTbEfKBxiBWdxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Dave Jiang <dave.jiang@intel.com>, "fenghua.yu@intel.com"
	<fenghua.yu@intel.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [External Mail] Re: [PATCH][RFC] dmaengine: idxd: Fix possible
 Use-After-Free in irq_process_work_list
Thread-Topic: [External Mail] Re: [PATCH][RFC] dmaengine: idxd: Fix possible
 Use-After-Free in irq_process_work_list
Thread-Index: AQHar/3Qy6lGGrWqC0CaT4H6iVA4CbGsUdwAgAGfXsA=
Date: Wed, 29 May 2024 09:15:26 +0000
Message-ID: <9968be03b6064a84b6f1aaf99fc6c5e1@baidu.com>
References: <20240527061920.48626-1-lirongqing@baidu.com>
 <7b96aa7d-4e23-40dd-81de-1e60660c02dd@intel.com>
In-Reply-To: <7b96aa7d-4e23-40dd-81de-1e60660c02dd@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.55
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 52:10:53:SYSTEM

PiBCZWNhdXNlIGlmIHRoZSBkZXNjcmlwdG9yIGlzIGZyZWVkIGFuZCBnaXZlbiBvdXQgdG8gYSBk
aWZmZXJlbnQgdGhyZWFkIHdoaWxlIHRoZQ0KPiBjb2RlIGlzIHN0aWxsIHdhbGtpbmcgdGhlIGxp
c3QsIHRoZSBpdGVyYXRvciBtYXkgaGl0IGEgYmFkIHBvaW50ZXIgZHVlIHRvIHRoZSBmcmVlZA0K
PiBkZXNjcmlwdG9yIHBvaW50aW5nIHRvIHNvbWV0aGluZyBlbHNlLg0KPiANCj4gQWxzbywgcGxl
YXNlIGluY2x1ZGUgYSBGaXhlcyB0YWcgZm9yIHRoZSBmaXguIFRoYW5rcyENCg0KDQpPaywgSSB3
aWxsIHNlbmQgVjIsIHRoYW5rcw0KDQpCcg0K

