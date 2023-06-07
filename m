Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B6A725FBC
	for <lists+dmaengine@lfdr.de>; Wed,  7 Jun 2023 14:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240827AbjFGMlQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Jun 2023 08:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240981AbjFGMlP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 7 Jun 2023 08:41:15 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F5C211C;
        Wed,  7 Jun 2023 05:40:49 -0700 (PDT)
X-GND-Sasl: kory.maincent@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686141616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9phVIS0e/lFfC3GD7+aSC8uqC30x4BUaROiQihg76T0=;
        b=eZcKa1Nfe9HDGz9j6YZL86/beNdcDQRsicfu2RzVlfl905aWB0t1CC4KVySK7KgEnD622b
        ekU5WGzaPngEXxAMQd+H641lqhd3kbDKffhg9N/tJDMtHcNLZK3O+AF1UBrj+92vPnNioZ
        Z996IweG9Rq/CFrMPDtjbgMZQrxEAzN6kroESMrpjZvhnA3cswmbYFOPjrrjOKq3w9C0eZ
        fRPJVcd5bZoC4WNyNu7FT/egtqroTusR+VfcRlXLrkeXZfdADsJzQgv5Id5tYODaKzAHe3
        O5GAGlwxKHWYuvTCAy8lFs6RHKvg1aZLJuVIEctXM4KpS4IldTUAGImhYn5NbQ==
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F21401C0008;
        Wed,  7 Jun 2023 12:40:14 +0000 (UTC)
Date:   Wed, 7 Jun 2023 14:40:14 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>, vkoul@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v11 3/4] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <20230607144014.6356a197@kmaincent-XPS-13-7390>
In-Reply-To: <20230607114950.zml4l2rs77cbeesy@mobilestation>
References: <20230520050854.73160-1-cai.huoqing@linux.dev>
        <20230520050854.73160-4-cai.huoqing@linux.dev>
        <20230607095832.6d6b1a73@kmaincent-XPS-13-7390>
        <20230607114950.zml4l2rs77cbeesy@mobilestation>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 7 Jun 2023 14:49:50 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> Hi K=C3=B6ry
> First of all. What is akida platform you are referring to? I failed to
> find any mention in the mainline kernel repo.

Yes, sorry akida is the project prefix I am currently working on.
It is simply a prefix for the symbol export to be different than mainline,
don't take it into account.

> > channels by doing the minimum between ll_wr_cnt and the ch_count callba=
ck.
> > The hdma ch_count callback is counting the number of channels enabled by
> > reading the number of ch_en registers set. At probe time there is no
> > channels registers that has been set as it is done later in the
> > dw_hdma_v0_core_start function. Then the dw_hdma_v0_core_ch_count will
> > always return 0 at probe time and the number of channels will be set to=
 0
> > which is not what we want. Could I miss something? =20
>=20
> Based on the HDMA patches content you are right. The channels must be
> pre-enabled in order to have the dw_hdma_v0_core_ch_count() procedure
> to work correctly otherwise you'll indeed end up with an empty list of
> channels. I don't have any device with the HDMA engine embedded so I
> couldn't have possibly tracked that peculiarity on review. Anyway
> AFAICS Cai just implemented a method which seemed to work for his
> hardware setup.

Alright, on my side I have a board using this FPGA implementation and it
indeed doesn't work as is.

> If you think it doesn't work correctly or it isn't portable enough
> then you are free to provide your own implementation of the method and
> submit a patch. I hope Cai will be willing to test it out to make sure
> that it works correctly for you and his platforms.
>=20
> As for me if I were on your place I would have implemented a loop
> which would walk over all possible HDMA channels (HDMA_V0_MAX_NR_CH)
> and counted all channels which could be enabled. If the ch_en CSR is
> writable (that is the channel could be enabled) then it shall be
> considered as existent. Of course before that I would have made sure
> that the non-existent channels had non-writable ch_en CSR.

This could be a nice idea but it doesn't work, non-existent channels seems =
to
be writable. The datasheet of the HDMA IP doesn't have any register to find=
 out
the maximum existent channel.=20
As there is no way to know this, the dw_hdma_v0_core_ch_count will simply
return HDMA_V0_MAX_NR_CH.
Cai how does it works on your side? does the ch_en register already enabled=
 by
the implementation?
