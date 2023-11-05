Return-Path: <dmaengine+bounces-48-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2B47E12D0
	for <lists+dmaengine@lfdr.de>; Sun,  5 Nov 2023 10:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2711C20902
	for <lists+dmaengine@lfdr.de>; Sun,  5 Nov 2023 09:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257A78C0C;
	Sun,  5 Nov 2023 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA4A8C13
	for <dmaengine@vger.kernel.org>; Sun,  5 Nov 2023 09:34:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712AAC0
	for <dmaengine@vger.kernel.org>; Sun,  5 Nov 2023 01:34:37 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qzZWd-0000Pc-T4; Sun, 05 Nov 2023 10:34:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qzZWb-006l7F-NG; Sun, 05 Nov 2023 10:34:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qzZWb-00D8nc-Do; Sun, 05 Nov 2023 10:34:33 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Vinod Koul <vkoul@kernel.org>
Cc: Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/4] dmaengine: Convert to platform remove callback returning void (part II)
Date: Sun,  5 Nov 2023 10:34:16 +0100
Message-ID: <20231105093415.3704633-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1453; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=d8qCup0cdwCDyUrt1w/mRjQzT4bdjh29/xjkX9x7Ao8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlT3xOlvzLYUHDaaX7J906nYvX4z/xi/9GYLPCqpF6Zgy lttczi1k9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJrN3M/t+tJW2S318Fb8Yt Am/7t90/8TR2o8xzo/DdCu3rEn8XbMtv0+P5e+7ip4b2+6zLuKtat4frtUWlRT14s1TEZELa4wh R60lTtlfc8pzvHtTIIjkh4FH5+tole76Km6o/W35J+QFXcmhEJ1fIdDkhTlftS+JzMsX2z7m+oO /EWeEO8SkVFTxFtRO4JrDNv2hs6S22dIVyONvtgD99Wb32qwSPamsYytdYrX0ZrcC+kONbsYLdz s7N60X2GbVI3RDl+yTzXPjmnou1smY7fv+OPfJR9I2hlebTTSqcO2L7RMtD11cLBJYV8O65rHkr LfWOSuzkI9bL4y+27CvkPRwsr9tT5+V16qR194qGVyu1AA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

Hello,

after
https://lore.kernel.org/all/20230919133207.1400430-1-u.kleine-koenig@pengutronix.de/
this series also converts the drivers that have a bogus error path in
their remove function. These patches don't fix the underlying problem
but still improve a bit, as the error message gets more detailed.

I don't know enough about the dma subsystem to propose a better fix, so
the drivers are only converted to use .remove_new() to not be in the way
for my quest to make struct platform_driver::remove return void. The
quest's goal is to prevent such bogus error paths to occur in new code.
See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation.

Best regards
Uwe

Uwe Kleine-König (4):
  dmaengine: milbeaut-hdmac: Convert to platform remove callback
    returning void
  dmaengine: milbeaut-xdmac: Convert to platform remove callback
    returning void
  dmaengine: uniphier-mdmac: Convert to platform remove callback
    returning void
  dmaengine: uniphier-xdmac: Convert to platform remove callback
    returning void

 drivers/dma/milbeaut-hdmac.c | 17 +++++++++++------
 drivers/dma/milbeaut-xdmac.c | 17 +++++++++++------
 drivers/dma/uniphier-mdmac.c | 17 +++++++++++------
 drivers/dma/uniphier-xdmac.c | 17 +++++++++++------
 4 files changed, 44 insertions(+), 24 deletions(-)

base-commit: e27090b1413ff236ca1aec26d6b022149115de2c
-- 
2.42.0


