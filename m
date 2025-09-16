Return-Path: <dmaengine+bounces-6562-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B58FB5A279
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40EE327BC7
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDCE3294E8;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF/U+ils"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF41305E26;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054325; cv=none; b=kTG14+IviuuETdivTQSatk5tJyQjA42zJACgZSPr8qxnbniWSPY8deta9OFtchjIEvOHIEQd1M3RTUWcvTg+4B/Wfl64SWkBkfGa4vg7XmupYNLTRpkpYIJ3mzX7ahuPjP4deLx5YV5xKKw7mzYDPc2nCed8aL8RMYqTCuL67Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054325; c=relaxed/simple;
	bh=PGC9RLyvUYb11AvcYKFthsR2RXxFjvbJW7ULzcMM1n4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pxxy1qXt3BWtQ/Xx6KR8hZo1En4AQoyoRA1aox8HrEusnN/f91f1XpSU07o7fM0yXtX49379XsZDaN9SO887JUC6ofqKf63mRtU5/uGrriHegwdgR7HQU8/40PpUbTPggkyR2nfCeCI9YAH4gIXjt4vDYwtjhvFOekhbEHNqibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF/U+ils; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31796C19422;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054325;
	bh=PGC9RLyvUYb11AvcYKFthsR2RXxFjvbJW7ULzcMM1n4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WF/U+ilsuMpWThSrx1H0QFkgdZaMVWBGJlBSSTATkfxZT6q0ZKb4HEFTUEJ8bf3nk
	 /k4vNhDzDpvL5piUH2exVhGXwpg+s+v9RNTKpicxPJd0y9eU3E78Bg3z2zRLns9qc+
	 9WSeaaXRF3arHwwhkyaEtB+r9wVDxgtL/iQYNJtCx2Ryhcy4NG3OKtbaFjbA/qW56I
	 so2OsPiqAPCn8xTAVqSBmuYU8dBFkHegK9FLvgeyX3VFjxSB78VL4MI7oZHBpfiyKR
	 3kuLWgcwvQJyZbL0BTXDZSjIghucFTYPeSVBE+dIsOVQriJdJ7oqnKUmV9S4bY87Jf
	 xREiIfqhBD1fQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216E8CAC5A0;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:01 +0700
Subject: [PATCH 04/25] rtc: Add timestamp for the end of 2127
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-4-9ca9184ca977@mainlining.org>
References: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
In-Reply-To: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Dang Huynh <dang.huynh@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=913;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=DzZHdJKZCRZsyIe84ay5pJ/2Z/eJ/DpBDRNQR5GG0kc=;
 b=TXUPCWPqfcmGpwTVgoZ/csRKglLlNBEzrYFxRh7ZQ//BPu6xMzaihEwxcAVhhtA00DbneF6R7
 Kv5Wv87ejuhBJCzOJ67wnp3h9v8C3HAnCIfUnZpMcrApewJyPWho9WA
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

Some RTC (like MT2712 and RDA Micro) can handle until the end of
the year 2127.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 include/linux/rtc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 95da051fb155dab4c8ec72ccae7b8e12a117a7f1..ec5828ccc7449388da2ab8bc757030e6795ace30 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -175,6 +175,7 @@ struct rtc_device {
 #define RTC_TIMESTAMP_END_2063		2966371199LL /* 2063-12-31 23:59:59 */
 #define RTC_TIMESTAMP_END_2079		3471292799LL /* 2079-12-31 23:59:59 */
 #define RTC_TIMESTAMP_END_2099		4102444799LL /* 2099-12-31 23:59:59 */
+#define RTC_TIMESTAMP_END_2127		4985971199LL /* 2127-12-31 23:59:59 */
 #define RTC_TIMESTAMP_END_2199		7258118399LL /* 2199-12-31 23:59:59 */
 #define RTC_TIMESTAMP_END_9999		253402300799LL /* 9999-12-31 23:59:59 */
 

-- 
2.51.0



