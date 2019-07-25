Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B925759FA
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2019 00:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfGYWCf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Jul 2019 18:02:35 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:47126 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfGYWCe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Jul 2019 18:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1564092151; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=heKcREY22PalpQ/9p8Cd9d1zdSepPrb23urjeSbGB5s=;
        b=mFrG2QDIrMMa1N2Z2OVlTuF1yYZ3LchMkFWqDfMspQ9nIQIHt+4ryyS8D1eO043/xYvhbR
        N2FT54nOWkY/RPgX2yiBHDmmzZM/1mmRTn9qpQrY04TflmjGu4/L1JyZ5aAqdEOpvFe+8V
        Dwl76dgF+6zF8aB9BWW/YLBVr0ngLbU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sebastian Reichel <sre@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     od@zcrc.me, devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 00/11] JZ4740 SoC cleanup
Date:   Thu, 25 Jul 2019 18:02:04 -0400
Message-Id: <20190725220215.460-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

This patchset converts the Qi LB60 MIPS board to devicetree and makes it
use all the shiny new drivers that have been developed or updated
recently.

All the crappy old drivers and custom code can be dropped since they
have been replaced by better alternatives.

Some of these alternatives are not yet in 5.3-rc1 but have already been
accepted by their respective maintainer for inclusion in 5.4-rc1.

To upstream this patchset, I think that as soon as MIPS maintainers
agree to take patches 01-03/11 and 11/11, the other patches can go
through their respective maintainer's tree.

Note for MIPS maintainers:
Patch 11/11 may conflict with the TCU patchset v15, should this one be
accepted upstream, but the conflict is tiny and easy to fix. Should this
case appear, don't hesitate to bother me about it.

Thanks,
-Paul


