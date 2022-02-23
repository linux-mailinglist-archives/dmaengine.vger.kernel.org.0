Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ADD4C0E37
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 09:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiBWI04 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 03:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbiBWI0z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 03:26:55 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF4069CF7;
        Wed, 23 Feb 2022 00:26:26 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DDF7C20008;
        Wed, 23 Feb 2022 08:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645604785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jNqFMUjFU/G/pXNU/btgCrYwtRlHw711d/iaQ8+6kE=;
        b=VGm4QGyvwwzn4qBmGAfQwkmJklLUeI4U7j7F+doEo5sbZuSUKMqDPCPBK4nPMlghX5QiNA
        ZYX3C7/VRze5xyP7STObbJ7F+W2+tGDrtp8cq63USilx0ua78gJi0yl1kSw7n7rr/5tQC1
        +uPMuofBbPQOvIibfbD7akpaVpKqA6O9SoRIQ7N9E+lOmPnnhah+BDKvL0Ixk990POuoDQ
        XhvmGU+TGkdpr4qYmHenBVNBu4ZG2xKP6TcJYJxb5feL4Xab+tK2oq0PVapr1Ogb0uPIJE
        fJVKEiWMeh9UtvVjICM/uv0aZqAjnbP3LQhNszuytmBEz0ktcH7iiJgjhl1rFw==
Date:   Wed, 23 Feb 2022 09:26:20 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kbuild-all@lists.01.org, dmaengine@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>
Subject: Re: [PATCH v2 4/8] dma: dmamux: Introduce RZN1 DMA router support
Message-ID: <20220223092620.19ccc836@xps13>
In-Reply-To: <202202230444.xjzzeOlo-lkp@intel.com>
References: <20220222103437.194779-5-miquel.raynal@bootlin.com>
        <202202230444.xjzzeOlo-lkp@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

> ERROR: modpost: missing MODULE_LICENSE() in drivers/dma/dw/dmamux.o
> ERROR: modpost: "r9a06g032_sysctrl_set_dmamux" [drivers/dma/dw/dmamux.ko]=
 undefined! =20

I will wait for more feedback against this version and then send a v3
with the missing macros.

Thanks,
Miqu=C3=A8l
