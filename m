Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF0D771B7
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2019 20:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbfGZS5w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Fri, 26 Jul 2019 14:57:52 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:55847 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387743AbfGZS5w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Jul 2019 14:57:52 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 8D5D2240009;
        Fri, 26 Jul 2019 18:57:43 +0000 (UTC)
Date:   Fri, 26 Jul 2019 20:57:42 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
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
        Richard Weinberger <richard@nod.at>,
        Sebastian Reichel <sre@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, od@zcrc.me,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH 07/11] mtd: rawnand: Drop obsolete JZ4740 NAND driver
Message-ID: <20190726205742.71210c24@xps13>
In-Reply-To: <20190725220215.460-8-paul@crapouillou.net>
References: <20190725220215.460-1-paul@crapouillou.net>
        <20190725220215.460-8-paul@crapouillou.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Paul,

Paul Cercueil <paul@crapouillou.net> wrote on Thu, 25 Jul 2019 18:02:11
-0400:

> It has been replaced with the newer Ingenic NAND driver.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
