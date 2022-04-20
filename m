Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85309508ABE
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 16:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379609AbiDTO2z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 10:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351242AbiDTO2z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 10:28:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE4E443DC;
        Wed, 20 Apr 2022 07:26:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 559F96174E;
        Wed, 20 Apr 2022 14:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB225C385A4;
        Wed, 20 Apr 2022 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650464765;
        bh=VBenOZQnhKSaKTDnmTU7YPn2Kk85+5G1iSKwpEyGiww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m7rZBwv9aWdNJd6Loy0eH5cEhgp+IzTLxDZNPLz2lHP3oHFa5kNcf6/YxolvF1KxG
         z7U/uiM2NQS1fZGGrbOAnLb1vts3dQpamCubqiMxPflwZAUrQ4ecKNnnZ7ysQJTnFh
         KmjPa7Ev/p/Q1/A5nrP+oMpyC41Suc8EDjKknK2oqNfcWcUAmbXEC2wl1ygieoWE7w
         eES15iHNN/CLXTq66bL2zyCiR5So+Zz0H2UjqvItPYVIPWxmFjv9jkPYDwM0JFk6qe
         Ccu+jIsxbEp37nootcADrepZ2FZsh82W4B+EpGpKmfMt1OTSWwj94cJKKGZ7HzX2S5
         pIw0f4X2L8SCQ==
Received: by mail-pg1-f173.google.com with SMTP id x191so1766889pgd.4;
        Wed, 20 Apr 2022 07:26:05 -0700 (PDT)
X-Gm-Message-State: AOAM532vvoR29z1zZYVTpGP8s0sq+Il4eG9zG7Vl3GRG0oMP5attE+JR
        MW65VgdtSEQhQo9VXBLn9FLUj2xp+5Sc7poqLw==
X-Google-Smtp-Source: ABdhPJxoI0QtEfC8n4+Ln+gp0b3QXWDDvTicJkjQ1klYrRPpw4OnJYVmtCTwaMTxb74RYk3qNMBwj0W1ciQ/08DtuWU=
X-Received: by 2002:a63:e70e:0:b0:3a9:eb7f:96c9 with SMTP id
 b14-20020a63e70e000000b003a9eb7f96c9mr15011577pgi.85.1650464765346; Wed, 20
 Apr 2022 07:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <CANXhq0r15Z9NZj+xr7K_2Tt5VbK2r4+f7Fpg-f9BY98ufgKxcw@mail.gmail.com>
 <mhng-75e55594-c878-4fad-9ffc-dc552111208e@palmer-ri-x1c9>
In-Reply-To: <mhng-75e55594-c878-4fad-9ffc-dc552111208e@palmer-ri-x1c9>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 20 Apr 2022 09:25:53 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+5TbfFxD3p4ckvNw=jFweuvjQPRQfjmvPqZJga25o0pA@mail.gmail.com>
Message-ID: <CAL_Jsq+5TbfFxD3p4ckvNw=jFweuvjQPRQfjmvPqZJga25o0pA@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Determine the number of DMA channels by
 'dma-channels' property
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Zong Li <zong.li@sifive.com>, Vinod <vkoul@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bin Meng <bin.meng@windriver.com>,
        Green Wan <green.wan@sifive.com>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Apr 19, 2022 at 7:18 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Mon, 11 Apr 2022 04:43:35 PDT (-0700), zong.li@sifive.com wrote:
> > On Mon, Apr 11, 2022 at 6:48 PM Vinod Koul <vkoul@kernel.org> wrote:
> >>
> >> On 11-04-22, 10:51, Zong Li wrote:
> >> > On Fri, Apr 8, 2022 at 9:13 PM Vinod Koul <vkoul@kernel.org> wrote:
> >> > >
> >> > > On 28-03-22, 17:52, Zong Li wrote:
> >> > > > The PDMA driver currently assumes there are four channels by default, it
> >> > > > might cause the error if there is actually less than four channels.
> >> > > > Change that by getting number of channel dynamically from device tree.
> >> > > > For backwards-compatible, it uses the default value (i.e. 4) when there
> >> > > > is no 'dma-channels' information in dts.
> >> > >
> >> > > Applied patch 1 & 4 to dmaengine-next, thanks
> >> >
> >> > Hi Vinod,
> >> > Thanks for your help and review. For patch 2 and 3, does it mean that
> >> > we should go through the riscv tree?
> >>
> >> Yes
> >>
> >
> > Hi Palmer,
> > Could you please help me to pick up the patch 2 and 3. Thanks :)
>
> Sorry about that, I forgot about this one.  I just put them on for-next,
> there was a minor merge conflict but it looks pretty simple.

Looks like you applied patch 1 too which Vinod already applied to the
dmaengine tree. And you changed the 1st line removing the "# " before
the SPDX tag which results in:

make[1]: *** Deleting file
'Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 52, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py",
line 434, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py",
line 119, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 718, in _ruamel_yaml.CParser.get_single_node
ruamel.yaml.composer.ComposerError: expected a single document in the stream
  in "<unicode string>", line 1, column 1
but found another document
  in "<unicode string>", line 2, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:26:
Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.example.dts]
Error 1
./Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml:1:1:
[error] missing document start "---" (document-start)


Rob
