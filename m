Return-Path: <dmaengine+bounces-2677-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D4C92E84F
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 14:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90C90B212A0
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 12:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E989615B97A;
	Thu, 11 Jul 2024 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Z1Lm4zyV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5354114C585
	for <dmaengine@vger.kernel.org>; Thu, 11 Jul 2024 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720701252; cv=none; b=l7NlNKzQamsBrTqgIMR/RN3lmlPKhatBFddk2XoC+DBGd+KtEiMRypU4nFsk8Qk94rMAsXx0VykJk/7rb96ycK5h83oy5kWfpDA3r6ssXlyFYmbfBbRYc3s4IBwLJ9xn5c+S0xp/lXi4VgE8/Gle9Y+bP/TfSCYknf+bu/FUqMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720701252; c=relaxed/simple;
	bh=SVNaY8uPYmFpQzt05SCgtnQKzfh+zub5JZo0eT+9Phg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LZFT9QjlJqGWSGZ8Udqh9SYn0cd2eaI0/Lm9CoWlfxfvSbydpx7Oa7nICBhX+hEKzEFqwNodTE++JOgU6hEtaSVedpvhFywIWC3HncuNkerxwgwm+Gzv3zRZxbezf06RErmfKYTkYdBPMR2WO8wn7qD/rbPOAQSxOxHZ6odWzVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Z1Lm4zyV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so5415525e9.2
        for <dmaengine@vger.kernel.org>; Thu, 11 Jul 2024 05:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720701250; x=1721306050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v9gF9Nlbjx+3WYbHXvq9fYfuO2GW0NccrZ1QB+XZf7o=;
        b=Z1Lm4zyVSvhDfmJwHgzoAdMhlTeGWvnPlgRXTe568rRUpNKQRjF/3eM0HXjIh94xJl
         ss3epwTRjcPMqB+cVbg7yg/yncI8PiJ6jGH1hv46XGFqTkMWriJuNOYe/l97RIFp1199
         yx4yS1lYe2vsnLM3hOg4Eiebbm5sj1SxHwGvOxaoW52XhPll9Jw3gjcMwqglDSbrQLX1
         FJYOi3KVph5tkOCK0ktt5FLuRRpgDFsi3WO6XFdI3+3MsATQADA+KRSicVw/1NFr7eEU
         hl9d/RpNZmos6qlLXqEri6xa6ekJNDQ9GG47PRFgtThwxQgSOfz9fFAkcM9r8gOhDiPC
         PeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720701250; x=1721306050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9gF9Nlbjx+3WYbHXvq9fYfuO2GW0NccrZ1QB+XZf7o=;
        b=g8nzcdHCK5XhQ9g/FJojPKsB+GF48fgHVy3zahgwE9rG+Nr5OwOS6We7caxYPcD7Oe
         GFp6b+4m/dgfTb5DHxL9B13HDle2fla2i3ILeozKBIBFgpjDP6d7TUvaN3wSbmURiQLH
         tQ/IK7k7JUk9iYIjtk2Y0Gtu2kHNzi3yfENu93XzWsvJ9s6o3x0uoFk9UIwDggD/bP/v
         8h0B+Vhhjj9mJuN62zo8Bze7py9yd21CaRo7tUyGjZMpPtTBzu/2SzhbIpWaxwJ+Oune
         a3RdB2EJVBWrZXpDbXu5oNIy1rJLCAQe/b1XO7G5Q1ytVZqCQ09Ybc/OcHNvuZmFwp4M
         0iMg==
X-Gm-Message-State: AOJu0YyNC2MYsaVgs16oA5YtlILojrW19qp+SwQqUxBWrSAUDNVDsp39
	0zET8hbqIuElCE3g7Kmx1+RTQCWkHyH39zK4hYInn4jvRxd7/J9WHIaJxlvrSfY=
X-Google-Smtp-Source: AGHT+IE5OyEhveFcUAtoaVHeQx6Q9QEh5xiYR0uZxQSYMrJpf+ubS8v9LD0epdhy9PvZtkshzAQd/Q==
X-Received: by 2002:a05:600c:17c7:b0:426:654e:16d0 with SMTP id 5b1f17b1804b1-4267018b105mr69388925e9.0.1720701249790;
        Thu, 11 Jul 2024 05:34:09 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f741fa6sm118583955e9.45.2024.07.11.05.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 05:34:09 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	biju.das.jz@bp.renesas.com
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 0/3] dma: Enable DMA support for the Renesas RZ/G3S SoC
Date: Thu, 11 Jul 2024 15:34:02 +0300
Message-Id: <20240711123405.2966302-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series enables the DMA support for the Renesas RZ/G3S SoC.
It adds DMA clock and reset support, updates the documentation and SoC
dtsi with DMA node.

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  clk: renesas: r9a08g045-cpg: Add DMA clocks and resets
  dt-bindings: dma: rz-dmac: Document RZ/G3S SoC
  arm64: dts: renesas: r9a08g045: Add DMAC node

 .../bindings/dma/renesas,rz-dmac.yaml         |  1 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 38 +++++++++++++++++++
 drivers/clk/renesas/r9a08g045-cpg.c           |  3 ++
 3 files changed, 42 insertions(+)

-- 
2.39.2


