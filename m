Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1843695650
	for <lists+dmaengine@lfdr.de>; Tue, 14 Feb 2023 03:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBNCEB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Feb 2023 21:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBNCEA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Feb 2023 21:04:00 -0500
Received: from out-209.mta1.migadu.com (out-209.mta1.migadu.com [IPv6:2001:41d0:203:375::d1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495002D6D
        for <dmaengine@vger.kernel.org>; Mon, 13 Feb 2023 18:03:59 -0800 (PST)
Date:   Tue, 14 Feb 2023 10:03:53 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676340237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eD7UjkPGZvdFIcp1h9xe+/jJqfTGRkEXEHj4xh5B/r4=;
        b=oFd+iidyFq9wmSbyh9uOjyaVtbw4tG9Lt0OYSJHNpv4O01rkAVZrOK00irv/gX80nGu51L
        U36la+0U882VlvbgGDi09/yTGRWI3jejLg4H0ETW0DPF4pUqxMxa3jfNMEtGMCY0ZG1uVu
        j80PyfLLQDNWxpJDGFFFUCu+pg0gQbU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sergey.Semin@baikalelectronics.ru,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <Y+rsCeTxVYy2Car0@chq-MS-7D45>
References: <20230213132411.65524-4-cai.huoqing@linux.dev>
 <20230213205927.GA2930625@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230213205927.GA2930625@bhelgaas>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13 2月 23 14:59:27, Bjorn Helgaas wrote:
> On Mon, Feb 13, 2023 at 09:24:08PM +0800, Cai Huoqing wrote:
> > From: Cai huoqing <cai.huoqing@linux.dev>
> > 
> > Add support for HDMA NATIVE, as long the IP design has set
> > the compatible register map parameter-HDMA_NATIVE,
> > which allows compatibility for native HDMA register configuration.
> 
> Rewrap to fill 75 columns.  Also applies below.
> 
> > The HDMA Hyper-DMA IP is an enhancement of the eDMA embedded-DMA IP.
> > And the native HDMA registers are different from eDMA,
> > so this patch add support for HDMA NATIVE mode.
> > 
> > HDMA write and read channels operate independently to maximize
> > the performance of the HDMA read and write data transfer over
> > the link When you configure the HDMA with multiple read channels,
> > then it uses a round robin (RR) arbitration scheme to select
> > the next read channel to be serviced.
> > The same applies when you have multiple write channels.
> 
> Wrap into a single paragraph or add a blank line if you want the last
> sentence to be a new paragraph.
> 
> > The native HDMA driver also supports a maximum of 16 independent
> > channels (8 write + 8 read), which can run simultaneously.
> > Both SAR (Source Address Register) and DAR (Destination Address Register)
> > are alignmented to byte.
> 
> s/alignmented/aligned/
> 
> > +	u32 watermark_en;			/* 0x0030 */
> > +	u32	control1;			/* 0x0034 */
> > +	u32	func_num;			/* 0x0038 */
> > +	u32	qos;				/* 0x003c */
> > +	u32	reserved;			/* 0x0040..0x007c */
> > +	u32 ch_stat;				/* 0x0080 */
> 
> Weird indentation of control1, func_num, etc.  Is that meaningful or a
> mistake?
> 
> > +	union {
> > +		u64 reg;			/* 0x00a0..0x00a4 */
> > +		struct {
> > +			u32 lsb;		/* 0x00a0 */
> > +			u32 msb;		/* 0x00a4 */
> > +		};
> > +	} msi_abort;
> > +	u32	msi_msgdata;			/* 0x00a8 */
> 
> Again here.
Will fix these in next version

Cai
> 
> Bjorn
