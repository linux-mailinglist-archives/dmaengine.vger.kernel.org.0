Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAC97D99D0
	for <lists+dmaengine@lfdr.de>; Fri, 27 Oct 2023 15:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345851AbjJ0NaD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Oct 2023 09:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345458AbjJ0NaC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Oct 2023 09:30:02 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CF2C9;
        Fri, 27 Oct 2023 06:29:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id F2B2C32009F8;
        Fri, 27 Oct 2023 09:29:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 27 Oct 2023 09:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1698413395; x=1698499795; bh=y/asV0jGE9KYJ5AX6cfLumj3ozye9Q5hc0a
        wXOwxYCA=; b=dEYH22qjxt/pOqINf9M2MS7SLiF793KNrKQttOs5Pk2ofveemOY
        ojyaQNHbO5es1CmWwc+6IxAd9RN1Vjak352mfiF6rSFmE1+Ll8jgOOSox2EW8Xnx
        CzSfaa0cYUO9SbTyqi4gxczIOpGGuUDqr7/kCNL7MUKTe0knyfL7aLO7aP8Nip5Y
        jLHfkjPc3ebwm2y+01f+Jpo7ACI9fZjU8slSnhVlMDXCGzIQ1D0PB4ZVo+k+j4ga
        4Nbha+Xj5H8dFL7/gOCbNH59hWmEXEQveHfCbJuoO+EDZKePEp73PbM/LXODnbL4
        SDQqqOnvtTPYIwyr5Wkg/njyCtadKFUhNXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698413395; x=1698499795; bh=y/asV0jGE9KYJ5AX6cfLumj3ozye9Q5hc0a
        wXOwxYCA=; b=ScyRCf4+KbB29Sya6lBwlUZ/2umSsqpe4jlIOEnfvqXuQo9nI7e
        B02TFzLUldHHvJly2IdP9WpEb4EWVtRBXMVCqFcmhWLeYUWi5lFrxYgU9/ROOQ8G
        7q6l1ppmtu3uo62nX7Rj3AAjhv2Sw0lFtyMebq5eS66+ZJQv6S65SEcTG5R9Vwjb
        pPSNyd5pZMmO/hgvMZtsdbWxld4Z2hdaqdLrGgiMmeNUC6FJgLU8cymrPGRww7Yu
        NXVesT5VC8dF9R7i3yFIqzsWKRolFT/qeBiUUK1k1CP2XITSAGs/dMDPT59c+b+H
        WfsscRp0L9cqL4ID5OsANLiNWUAYOyewYTg==
X-ME-Sender: <xms:U7s7ZVGm2p00eoWeD2CYZFYK5oZoXN5d9lMGGHKzacir7YzCIni4aw>
    <xme:U7s7ZaWyJ4B414gRv0lI-kOwDUQmOGzVcLlIF1xE9UvRN15WDcyUY23Pp5As6iSbT
    OkHx4axDQ2JuUCpvco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnheptdeiteeiueekueetveetkeetieekieffudehlefftdejkedtvedtudfhffef
    hffgnecuffhomhgrihhnpehlfihnrdhnvghtpdhkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgu
    sgdruggv
X-ME-Proxy: <xmx:U7s7ZXKm4_g3V9vnbKMAx2fn_NVvV0JOCN9A1aU5NUkWj9xVuhc5Kw>
    <xmx:U7s7ZbG2cxKzEjhYi0eMil-CQM1MUnN5y8kbhkP0OEBEJGHj9nm2kQ>
    <xmx:U7s7ZbWT1_ZQ-nSBBcgDj5K-wtHv1P8QBqmoR-yIcph7VKMI0x2TgQ>
    <xmx:U7s7ZXoPcVyfG4Es4i4R_5OdZ3rUXTzS8Djg9U1iHk05Xl_LEW-WIw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E52D9B60089; Fri, 27 Oct 2023 09:29:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <7acec62a-6b5c-4635-b486-ceadee279f35@app.fastmail.com>
In-Reply-To: <415ae047-0c9e-1e85-f4ff-e17a63aa0dfc@amd.com>
References: <20231023160539.1537355-1-arnd@kernel.org>
 <20231023160539.1537355-2-arnd@kernel.org>
 <78427021-ddc0-45b6-a16b-bf8bc8f84003@app.fastmail.com>
 <415ae047-0c9e-1e85-f4ff-e17a63aa0dfc@amd.com>
Date:   Fri, 27 Oct 2023 15:29:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lizhi Hou" <lizhi.hou@amd.com>, "Arnd Bergmann" <arnd@kernel.org>,
        "Martin Tuma" <martin.tuma@digiteqautomotive.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        dmaengine@vger.kernel.org, "Brian Xu" <brian.xu@amd.com>,
        "Raj Kumar Rampelli" <raj.kumar.rampelli@amd.com>,
        "Vinod Koul" <vkoul@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: pci: mgb4: remove bogus 'select' statements
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Oct 24, 2023, at 18:18, Lizhi Hou wrote:
> On 10/24/23 06:27, Arnd Bergmann wrote:
>> On Mon, Oct 23, 2023, at 18:05, Arnd Bergmann wrote:
>>
>> aarch64-linux-ld: drivers/media/pci/mgb4/mgb4_core.o: in function `in=
it_i2c': mgb4_core.c:(.text+0x3ec): undefined reference to `xdma_get_use=
r_irq'
>> aarch64-linux-ld: mgb4_core.c:(.text+0x404): undefined reference to `=
xdma_enable_user_irq'
>>
>> I couldn't easily figure out what a 'user_irq' is here,
>> but I wonder if this is the expected way to use the DMA engine
>> layer. Maybe this should have been a nested irqchip instead,
>> or it should be encoded in the DMA request specifier?
>
> Hi Arnd,
>
> Here is a brief description of 'user_irq' and 'xdma_enable_user_irq'
>
> The XDMA subsystem is used in conjunction with the PCIe IP block. Plea=
se=20
> see https://lwn.net/Articles/911496/ for the overall information.
>
> XDMA can forward PCIe msi-x interrupt to/from user logic hardware (e.g=
.=20
> Digiteq device) which is connected to its user irq pin.=C2=A0 And XDMA=
 has a=20
> register to enable/disabe interrupt forwarding for a specific user irq=
 pin.
>
> 'xdma_enable_user_irq' and 'xdma_disable_user_irq' are provided for=20
> hardware driver which is designed to use XDMA to enable/disable its=20
> interrupt. And based on the previous discussion with Mark, Digiteq=20
> device does not use its own register to enable/disable interrupt but=20
> relies on XDMA.=C2=A0 Please see=20
> https://lore.kernel.org/lkml/daccee4a-ac3c-bfc1-4876-24e6ecf5bcf1@gpxs=
ee.org/

Ok, in this case, I would suggest using 'depends on XILINX_XDMA'
instead of the 'select' statement. I'll send a v2.

     Arnd
