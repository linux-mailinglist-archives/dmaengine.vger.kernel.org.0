Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05C73DAF13
	for <lists+dmaengine@lfdr.de>; Thu, 17 Oct 2019 16:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfJQOEK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Oct 2019 10:04:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727542AbfJQOEK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Oct 2019 10:04:10 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7258621848;
        Thu, 17 Oct 2019 14:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571321048;
        bh=Q+CIbW5hWN6LU9dHP1eWy5eKT4TsIQ0X62levLVmljg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B3STYhDzZ4yKr8riMTRMxdXQ18ObBJlcjzutrorC5ZT6vGzaADCEN3oTnBA962ooX
         RJ0Dfvgi2HxIEflMVaNQ33N2DhCDnOI23So8VfH1iS5DQW5p3Umhe0CwIJVl0hnlTX
         GZSuTcMxvr3TtpzFXPtsycB2zTUR7B66JewywZ/o=
Received: by mail-yb1-f177.google.com with SMTP id t4so731600ybk.3;
        Thu, 17 Oct 2019 07:04:08 -0700 (PDT)
X-Gm-Message-State: APjAAAWDQBYHcX6JFcpUnNoDA6ntka/jRCiPL4eOAHrdOoUy4hJGm/qc
        IbLtc+Uxedq6etoLxd6jzagsJyGQV0w34dQ/0g==
X-Google-Smtp-Source: APXvYqzYYUwsLXd2V5tk8mtnPoKQ8x+6MZmaA0AJXKDmtcnA6M7HsmYniLbbc+lpFZSkPNZkHf/TXCYoC1rvAZLN5TU=
X-Received: by 2002:a25:3ce:: with SMTP id 197mr2185522ybd.255.1571321047509;
 Thu, 17 Oct 2019 07:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191001061704.2399-1-peter.ujfalusi@ti.com> <20191001061704.2399-8-peter.ujfalusi@ti.com>
 <20191010175232.GA24556@bogus> <ef07299b-eb43-d582-adb8-46f46681f9a5@ti.com> <d53f3bd7-d331-33c8-5232-c8f3cc9ac708@ti.com>
In-Reply-To: <d53f3bd7-d331-33c8-5232-c8f3cc9ac708@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 17 Oct 2019 09:03:55 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKWVLMa=AJ+SNHjMRFpCk6cM=UPBgmmHVonOQ03a_zxXQ@mail.gmail.com>
Message-ID: <CAL_JsqKWVLMa=AJ+SNHjMRFpCk6cM=UPBgmmHVonOQ03a_zxXQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/14] dt-bindings: dma: ti: Add document for K3 UDMA
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, Keerthy <j-keerthy@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>, Vinod <vkoul@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Oct 15, 2019 at 12:29 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
> Rob,
>
> On 10/11/19 10:30 AM, Peter Ujfalusi wrote:
> >
> > I have already moved the TR vs Packet mode channel selection, which does
> > make sense as it was Linux's choice to use TR for certain cases.
> >
> > If I move these to code then we need to have big tables
> > struct psil_config am654_psil[32767] = {};
> > struct psil_config j721e_psil[32767] = {};
>
> After thinking about this a bit more, I think we can move all the PSI-L
> endpoint configuration to the kernel as not all the 32767 threads are
> actually in use. Sure it is going to be some amount of static data in
> the kernel, but it is an acceptable compromise.
>
> The DMA binding can look like this:
>
> dmas = <&main_udmap 0xc400>,
>        <&main_udmap 0x4400>;
> dma-names = "tx", "rx";
>
> or
> dmas = <&main_udmap 0x4400 UDMA_DIR_TX>,
>        <&main_udmap 0x4400 UDMA_DIR_RX>;
> dma-names = "tx", "rx";
>
> If I keep the direction.
> 0xc400 is destination ID, which is 0x4400 | 0x8000 as per PSI-L
> specification.
> In the TRM only the source threads can be found as a map (thread IDs <
> 0x7fff), but the binding document can cover this.
>
> This way we don't need another dtsi file and I can create the map in the
> kernel.
>
> This will hide some details of the HW from DT, but since the PSI-L
> thread configuration is static in hardware I believe it is acceptable.
>
> However we still have uncovered features in the binding or in code, like
> a case when the RX does not have access to the DMA channel, only flows.
> Not sure if I should reserve the direction parameter as an indication to
> this or find other way.
> Basically we communicate on the given PSI-L thread without having a DMA
> channel as other core is owning the channel.
>
> What do you think?

Seems like a reasonable solution though I don't really follow the last issue.

Rob
