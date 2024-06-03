Return-Path: <dmaengine+bounces-2241-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A7A8D7978
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jun 2024 03:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924A5281211
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jun 2024 01:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5AD1362;
	Mon,  3 Jun 2024 01:06:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A1C10E6
	for <dmaengine@vger.kernel.org>; Mon,  3 Jun 2024 01:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717376804; cv=none; b=Yk0aSwrbkV0gB7Uc6VfgM7FsNVy2Gq2lnW6R+O8HOzp42JzowgUo7HOnA1xUa7gHdQqNpLKEz+vS5iuVlKfTjCZRQy7zx6SnrBDs0GSuFWYgxND0Frh8nZKhv+oRbFz3AWVxcFTAiebSK7c66Nrc7exxodzCChQrilIH2qX4mtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717376804; c=relaxed/simple;
	bh=6TeMlN6uSHvNqfRRmV0IUqd/soiXO1kiU76tOj5Wzn8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IhvpGacPPbIxq+vP6czCSyp7qvrPG4j2SOr4D3UNA0oUlr1mm7XrvjWDhw9f3URiFKwPEPXZg1r+GG8aTv3C0nZetR9T6XGJ88HingP2OExN0WawDfm00lG9K4ahJqzJctYjFC020qIsDIykUxcHmGvEluCtxWeXLAGhWWmrzhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Dave Jiang <dave.jiang@intel.com>, "fenghua.yu@intel.com"
	<fenghua.yu@intel.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [External Mail] Re: [PATCH][v3] dmaengine: idxd: Fix possible
 Use-After-Free in irq_process_work_list
Thread-Topic: [External Mail] Re: [PATCH][v3] dmaengine: idxd: Fix possible
 Use-After-Free in irq_process_work_list
Thread-Index: AQHaslUOSSqJDeqphEe27+HFrYyfrrGvYzgAgAXcK+A=
Date: Mon, 3 Jun 2024 01:06:12 +0000
Message-ID: <608192b7061442c18ac888ac11628794@baidu.com>
References: <20240530054852.8858-1-lirongqing@baidu.com>
 <efc77091-0760-4ae8-b932-6dde63c0f62e@intel.com>
In-Reply-To: <efc77091-0760-4ae8-b932-6dde63c0f62e@intel.com>
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

PiBNYXliZSBzYXkgaXQgbGlrZSB0aGlzOg0KPiANCj4gVXNlIGxpc3RfZm9yX2VhY2hfZW50cnlf
c2FmZSgpIHRvIGFsbG93IGl0ZXJhdGluZyB0aHJvdWdoIHRoZSBsaXN0IGFuZCBkZWxldGluZw0K
PiB0aGUgZW50cnkgaW4gdGhlIGl0ZXJhdGlvbiBwcm9jZXNzLiBUaGUgZGVzY3JwdG9yIGlzIGZy
ZWVkIHZpYQ0KPiBpZHhkX2Rlc2NfY29tcGxldGUoKSBhbmQgdGhlcmUncyBhIHNsaWdodCBjaGFu
Y2UgbWF5IGNhdXNlIGlzc3VlIGZvciB0aGUgbGlzdA0KPiBpdGVyYXRvciB3aGVuIHRoZSBkZXNj
cmlwdG9yIGlzIHJldXNlZCBieSBhbm90aGVyIHRocmVhZCB3aXRob3V0IGl0IGJlaW5nDQo+IGRl
bGV0ZWQgZnJvbSB0aGUgbGlzdC4NCj4gDQoNClRoaXMgY2hhbmdlbG9nIGlzIGJldHRlciwgSSB3
aWxsIHNlbmQgdjQgd2l0aCB0aGlzIGNoYW5nZWxvZw0KDQpUaGFuayB5b3UgdmVyeSBtdWNoDQo=

