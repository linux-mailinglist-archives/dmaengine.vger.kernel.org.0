Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F299F76BD28
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 21:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjHATAD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Aug 2023 15:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjHAS7v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Aug 2023 14:59:51 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F5C2698
        for <dmaengine@vger.kernel.org>; Tue,  1 Aug 2023 11:59:48 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 175C9240002;
        Tue,  1 Aug 2023 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690916387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JbKw5gaSsQ1KP6WpWZQPn/tKg8KBQ7LDzEFzFE6q8yY=;
        b=O9Oec+ezm9L+4hlZ+pcQ+0RE8cywlmiIcwC4p7KSqs9UtttNoTv/jEu86HYkwb5JFzeHme
        WOY0Z1CHIDfJXTd37fnav9btDHt4mxSPyjEqalb8DaM4I0I36pcIuID/FDKrnAcH56y6Dm
        iVGlHJGN71idRQioDf4Ifq5PB5cVrgT90zIN+GB9kXEDqJoK+VBDoIIlpC7IFKMdOROsYs
        iYYGEaem/sU4igb2WXxSAgtLzLNChRZe4VrPok6slBzWHqSg6VZq2/LzugCQwLzndqTw/h
        FnIm92NIAbPQO84cqXnZCsup/Ld/Z+/NPTTUE81SKRFjk80HBQMAP5U+9XbtCg==
Date:   Tue, 1 Aug 2023 20:59:44 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Max Zhen <max.zhen@amd.com>,
        Sonal Santan <sonal.santan@amd.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: (subset) [PATCH 0/4] dmaengine: xdma: Cyclic transfers support
Message-ID: <20230801205944.445a6f31@xps-13>
In-Reply-To: <169091549012.69326.11492636667033832683.b4-ty@kernel.org>
References: <20230731101442.792514-1-miquel.raynal@bootlin.com>
        <169091549012.69326.11492636667033832683.b4-ty@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

vkoul@kernel.org wrote on Wed, 02 Aug 2023 00:14:50 +0530:

> On Mon, 31 Jul 2023 12:14:38 +0200, Miquel Raynal wrote:
> > Following the introduction of scatter-gather support of Xilinx's XDMA IP
> > in the Linux kernel, here is a small series adding cyclic transfers.
> >=20
> > The first patch is a real bug fix which triggered in my case, the second
> > just fixes a typo, the third one is a preparation patch to ease the
> > review of the fourth one which actually adds cyclic transfers support.
> >=20
> > [...] =20
>=20
> Applied, thanks!
>=20
> [1/4] dmaengine: xilinx: xdma: Fix interrupt vector setting
>       commit: d27a7028ba7214963eae3e3c266070a4a9f5725e
> [2/4] dmaengine: xilinx: xdma: Fix typo
>       commit: c3633b42923dae5c23a7fadaca6f10f8448b8fec

Thanks!

I assume you will probably make additional remarks on patch 4/4, if
however you are waiting for a re-spin just let me know.

Cheers,
Miqu=C3=A8l
