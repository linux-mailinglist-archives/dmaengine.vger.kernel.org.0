Return-Path: <dmaengine+bounces-661-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8058C81E4F7
	for <lists+dmaengine@lfdr.de>; Tue, 26 Dec 2023 06:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE831B21995
	for <lists+dmaengine@lfdr.de>; Tue, 26 Dec 2023 05:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19EB4AF98;
	Tue, 26 Dec 2023 05:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semidrive-com.20200927.dkim.feishu.cn header.i=@semidrive-com.20200927.dkim.feishu.cn header.b="TXTGPZDj"
X-Original-To: dmaengine@vger.kernel.org
Received: from va-2-39.ptr.blmpb.com (va-2-39.ptr.blmpb.com [209.127.231.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8104AF95
	for <dmaengine@vger.kernel.org>; Tue, 26 Dec 2023 05:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semidrive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semidrive.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=semidrive-com.20200927.dkim.feishu.cn; t=1703567722;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=vHeWsMfM12kuVaIVTOroSE1f22ig5Ahs9GSqrLGp8P8=;
 b=TXTGPZDjiEa6rva1LVYiPD8bqUM1aKr+mDf5bK1UqrE84gMYXY9GrjVbIr5JfJVtaCduO9
 809Tvsg8ZenA3yKQWcx6/0jlMhWmegSjn0G4IGz3ybfe8V2Of9AhSDrBIksiCCo8MSEC2E
 Lmn/WyAtfw2oVGG0u10Ckgb7UXEfqfI9wWw7pAtrw8kmyaLUv1W0rnTil3dw4rI+Ee4Yuf
 pEbSfBDcTq/ZJmu2HRtbazdIjBHYHX8Lpf71AVJ8gB2Za+2JPbPKB7bqS0vzjq52eSZO8O
 Va80dgttR1k5IMMoGvPog6Af0/G/8pk45Md6wxhYFgHQXnaH1BOJ9w0xhld23Q==
Cc: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yi.shao@semidrive.com>
From: "yi.shao" <yi.shao@semidrive.com>
Content-Transfer-Encoding: base64
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH] dmaengine: virt-dma:fix vchan_dma_desc_free_list list_del corruption.
Date: Tue, 26 Dec 2023 13:15:17 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <1703567717-71861-1-git-send-email-yi.shao@semidrive.com>
Received: from nj-bsvm040.semidrive.cc ([58.213.129.90]) by smtp.feishu.cn with ESMTPS; Tue, 26 Dec 2023 13:15:20 +0800
To: <vkoul@kernel.org>
X-Lms-Return-Path: <lba+2658a6169+221b41+vger.kernel.org+yi.shao@semidrive.com>
X-Original-From: "yi.shao" <yi.shao@semidrive.com>

VG8gcmVzb2x2ZSB0aGUgcmFjZSBwcm9ibGVtIHdoZW4gdGVybWluYXRpbmcgYSBjeWNsaWMgdHJh
bnNmZXIsDQpkbWFlbmdpbmUgY2FsbHMgdmNoYW5fdGVybWluYXRlX3ZkZXNjKCkgZnJvbSB0aGUg
RE1BIHRlcm1pbmF0ZV9hbGwNCmZ1bmN0aW9uLg0KDQpXaGVuIGNvbmZpZ3VyaW5nIHRoZSBDT05G
SUdfREVCVUdfTElTVCBtYWNybywgaXQgZGV0ZWN0cyBhIGxpc3QNCmNvcnJ1cHRpb24gZXJyb3Ig
aW4gdGhlIHZjaGFuX2RtYV9kZXNjX2ZyZWVfbGlzdCBmdW5jdGlvbiwgZGlzcGxheWluZw0KdGhl
IGZvbGxvd2luZyBtZXNzYWdlOiAiWzU0Ljk2NDcwMl0gbGlzdF9kZWwgY29ycnVwdGlvbi4gcHJl
di0+bmV4dA0Kc2hvdWxkIGJlIGZmZmZhMDAwMTM5NWEwYjgsIGJ1dCBpdCB3YXMgZmZmZmEwMDAx
ODBhNzk1MCIuDQoNClRoaXMgZXJyb3Igb2NjdXJzIGJlY2F1c2UgdGhlIHZpcnRfZG1hX2Rlc2Mg
cmVtYWlucyBpbiB0aGUNCnZjLT5kZXNjX2lzc3VlZCBsaXN0LlRvIHJlc29sdmUgdGhpcyBpc3N1
ZSwgdGhlIHZjaGFuX3Rlcm1pbmF0ZV92ZGVzYw0KZnVuY3Rpb24gc2hvdWxkIHJlbW92ZSB0aGUg
ZGVzY3JpcHRvciBmcm9tIHZjLT5kZXNjX2lzc3VlZCBhbmQgdGhlbg0KYWRkIGl0IHRvIHZjLT5k
ZXNjX3Rlcm1pbmF0ZWQuDQoNClNpZ25lZC1vZmYtYnk6IHlpLnNoYW8gPHlpLnNoYW9Ac2VtaWRy
aXZlLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZG1hL3ZpcnQtZG1hLmggfCAxICsNCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL3ZpcnQtZG1h
LmggYi9kcml2ZXJzL2RtYS92aXJ0LWRtYS5oDQppbmRleCBlOWY1MjUwLi5lZWU5N2QyIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9kbWEvdmlydC1kbWEuaA0KKysrIGIvZHJpdmVycy9kbWEvdmlydC1k
bWEuaA0KQEAgLTE0Niw2ICsxNDYsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgdmNoYW5fdGVybWlu
YXRlX3ZkZXNjKHN0cnVjdCB2aXJ0X2RtYV9kZXNjICp2ZCkNCiB7DQogCXN0cnVjdCB2aXJ0X2Rt
YV9jaGFuICp2YyA9IHRvX3ZpcnRfY2hhbih2ZC0+dHguY2hhbik7DQogDQorCWxpc3RfZGVsKCZ2
ZC0+bm9kZSk7DQogCWxpc3RfYWRkX3RhaWwoJnZkLT5ub2RlLCAmdmMtPmRlc2NfdGVybWluYXRl
ZCk7DQogDQogCWlmICh2Yy0+Y3ljbGljID09IHZkKQ0KLS0gDQoyLjcuNA0K5rOo5oSP77ya5pys
55S15a2Q6YKu5Lu25oiW5YW25Lu75L2V6ZmE5Lu25bGe5LqO5Y2X5Lqs6Iqv6amw5Y2K5a+85L2T
56eR5oqA5pyJ6ZmQ5YWs5Y+45Y+K5YW25ZCE5YiG5a2Q5YWs5Y+477yI4oCc6Iqv6amw56eR5oqA
4oCd77yJ5omA5pyJ44CC5pys55S15a2Q6YKu5Lu25oiW5Lu75L2V6ZmE5Lu25LuF5L6b5pS25Lu2
5Lq65oiW5pS25Lu25a6e5L2T5L2/55So44CC5pys55S15a2Q6YKu5Lu25oiW5Lu75L2V6ZmE5Lu2
5Y+v6IO95YyF5ZCr6Iqv6amw56eR5oqA55qE5py65a+G5L+h5oGv44CC56aB5q2i5Lu75L2V5pyq
57uP5o6I5p2D5L2/55So44CB5aSN5Yi244CB5Lyg5pKt5oiW5Zug5L6d6LWW5pys55S15a2Q6YKu
5Lu26ICM6YeH5Y+W5oiW5LiN6YeH5Y+W55qE5Lu75L2V5YW25LuW6KGM5Yqo44CC5aaC5p6c5oKo
5LiN5piv5q2k55S15a2Q6YKu5Lu255qE6aKE5pyf5pS25Lu25Lq677yM6K+36YCa6L+H5Zue5aSN
55S15a2Q6YKu5Lu26YCa55+l5Y+R5Lu25Lq677yM5bm25LuO5oKo55qE57O757uf5Lit5Yig6Zmk
5q2k6YKu5Lu25ZKM5Lu75L2V6ZmE5Lu244CC6Z2e5bi45oSf6LCi44CCCkF0dGVudGlvbu+8mlRo
aXMgZW1haWwgb3IgYW55IGF0dGFjaG1lbnRzIHRoZXJlb2YgYmVsb25nIHRvIE5hbmppbmcgU2Vt
aWRyaXZlIFRlY2hub2xvZ3kgTHRkIGFuZCBlYWNoIG9mIGl0cyBhZmZpbGlhdGVzIGFuZCBzdWJz
aWRpYXJpZXPvvIgiU2VtaURyaXZlIEdyb3VwIu+8iS5UaGlzIGVtYWlsIG9yIGFueSBhdHRhY2ht
ZW50cyBhcmUgaW50ZW5kZWQgb25seSBmb3IgdXNlIGJ5IHRoZSBpbmRpdmlkdWFsIG9yIGVudGl0
eSB0byB3aGljaCBpdCBpcyBhZGRyZXNzZWQuIFRoaXMgZW1haWwgb3IgYW55IGF0dGFjaG1lbnRz
IG1heSBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBvZiBTZW1pRHJpdmUgR3JvdXAu
IEFueSB1bmF1dGhvcml6ZWQgdXNlLCBjb3B5aW5nLCBkaXNzZW1pbmF0aW9uIG9yIGFueSBvdGhl
ciBhY3Rpb24gdGFrZW4gb3Igb21pdHRlZCB0byBiZSB0YWtlbiBpbiByZWxpYW5jZSB1cG9uIHRo
aXMgZW1haWwgaXMgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lw
aWVudChzKSBvZiB0aGlzIGVtYWls77yMUGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJlcGx5
IGUtbWFpbCBhbmQgZGVsZXRlIHRoZSBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudHMgZnJvbSB5
b3VyIHN5c3RlbS4gVGhhbmsgeW91Lg==

