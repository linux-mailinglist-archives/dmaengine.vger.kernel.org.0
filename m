Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0453B7717A
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2019 20:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388146AbfGZSpb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Jul 2019 14:45:31 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:43974 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387440AbfGZSpb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Jul 2019 14:45:31 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 05C2720117;
        Fri, 26 Jul 2019 20:45:23 +0200 (CEST)
Date:   Fri, 26 Jul 2019 20:45:22 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
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
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>,
        alsa-devel@alsa-project.org, linux-pm@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        linux-mtd@lists.infradead.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 05/11] video/fbdev: Drop JZ4740 driver
Message-ID: <20190726184522.GB14981@ravnborg.org>
References: <20190725220215.460-1-paul@crapouillou.net>
 <20190725220215.460-6-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725220215.460-6-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=p6pI0oa4AAAA:8 a=7gkXJVJtAAAA:8 a=_OfsqKrkMx9ODVYiAzcA:9
        a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22 a=9cw2y2bKwytFd151gpuR:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Paul.

On Thu, Jul 25, 2019 at 06:02:09PM -0400, Paul Cercueil wrote:
> The JZ4740 fbdev driver has been replaced with the ingenic-drm driver.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  drivers/video/fbdev/Kconfig     |   9 -
>  drivers/video/fbdev/Makefile    |   1 -
>  drivers/video/fbdev/jz4740_fb.c | 690 --------------------------------
>  3 files changed, 700 deletions(-)
>  delete mode 100644 drivers/video/fbdev/jz4740_fb.c
Nice work of you and others involved.

Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
