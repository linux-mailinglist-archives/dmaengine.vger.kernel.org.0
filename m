Return-Path: <dmaengine+bounces-6549-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EDBB5A1FE
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744021C0141D
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B54231FEC8;
	Tue, 16 Sep 2025 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="D81tWIkX";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="vN3Lu7A/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BE23074BC;
	Tue, 16 Sep 2025 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053398; cv=none; b=IWfOlEyHptNgkgQxRV/2t5AvhvmYFb/DDe3l/OcIGnME/JlL4H8Rb5K5MkfpKqz5eQtiBHBEnpbXzOPWzYXna9qbSokas2xmTBeIw4JFNZXVnDwKiuUwUFLnuQzoKXZjKrB6fS+ahQssbM89dXFy2+Ttmtm13JI/1rx4Ga5Vlqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053398; c=relaxed/simple;
	bh=DzZHdJKZCRZsyIe84ay5pJ/2Z/eJ/DpBDRNQR5GG0kc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uZ7CmqZteVEVINEt05JxnHsmdP/6Me1G41ffehER1LdElWug9BCwidTEdcG7gXsOGx2ZOd25M7rJUV3YuaLJLXhr6W4EqGIEHiGmCFiQJIjpUhZFYX7QxWdlOC7sfxBaapgCvQqWFPQhNpvU4hX/vXQUMQ+titNqahfpadkhDFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=D81tWIkX; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=vN3Lu7A/; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1758053302; bh=oxyKpGaevdX8qzFvWgJnjXd
	deL4fgWyDYB+tXskt0Mo=; b=D81tWIkXyJ82G+KN1ps5eQF2I4UGKqUNEoDzxjadAwW5e5TJxL
	xCb4/7ziZYL5KVp0obAVsahMsHbbgvfdK5P4bqwG2T2PDVktlNgSZd1Ly9ydyA5TIEd+2x6RWxu
	bgDOl7gvtwC2fBcg4dRfjDXx7sjoxVb0nTW3bZ8ooJwNJgEAbZ6c2Gp1mwrkccT6E5HKMWjhmAv
	HmbCw98BuG/QhUB+joM9SRJ6UQH9RGOkrHlnBV0oiEP03BHVI2MJVpNJr2Xu4g+Cun9N1OGxR1g
	i+P54a8bsCHN5PvI3OGd/aW1RdqTJKAZGNyn7arxXv3BAubYzGZ3+d1a7J+l58QylIA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1758053302; bh=oxyKpGaevdX8qzFvWgJnjXd
	deL4fgWyDYB+tXskt0Mo=; b=vN3Lu7A/HWa/cz9tiEIR0Jnq+N4EnamrtRNsC56oqRgBpVEuW+
	EfAFWSOeXHo0Q0rl/0wPgy4PAUWRCkd3e/AQ==;
From: Dang Huynh <dang.huynh@mainlining.org>
Date: Wed, 17 Sep 2025 03:07:21 +0700
Subject: [PATCH 04/25] rtc: Add timestamp for the end of 2127
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-4-74866def1fe3@mainlining.org>
References: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
In-Reply-To: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
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


