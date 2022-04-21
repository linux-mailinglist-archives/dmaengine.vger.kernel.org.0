Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E6F50947F
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 03:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383544AbiDUBLC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 21:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356549AbiDUBLB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 21:11:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65D5CC0
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 18:08:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y32so5988595lfa.6
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 18:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PaUnbNt+lm1u9yE5wisBRk3m4mxTkfso+o7EcsoYb9U=;
        b=mMgyk5nz/Y8n1Lj6vrQUNd5iJAn2E+0233wITVfUWqbApNDLFv2P7b27+6eSzJoWDL
         t0nahvOc6wJ15MiIpsKeWs0NrqXR9RXJkkBDs3+5092owdZdTLhhNj+VLA8H1rGYQhNB
         lXc9cpxs8m5Z3IuIVwneY0LQqDwM8QSs17KSD3OaJ5Hkkhve7Yzrv8XLkplj9scNw0Mh
         op+UpykXWdb3gRwDuvNZCqSStJBVDMmlmxRoZdim+0kJtGzaUFQ7AOdKSmt9q22xGyfy
         hzxcH+ZtySQMf/xAuovtiEg2lwqVUhpujH0WofcH75OafGIP6rnLjPmoGN7EKHwffPF2
         oQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PaUnbNt+lm1u9yE5wisBRk3m4mxTkfso+o7EcsoYb9U=;
        b=racLurqBUs6ng19egqdxfxO7Tac8Z6VQsxcYJrECmDIRakA965EcenS0SS89OBSeGN
         falAaNnt+Ji6z7u7pJKCuqigYWgd8h/1WkIY5NPwFMnjTzHA/QDDybERsGjV8ASGQ00X
         IpYxg+sxTDc3L/Pwqp2+1enUyfJB9stq6MoJYu16eBqx+/LSj2YHLI67x3vjIOwod9Jy
         dvP1rTVXpSTJ60URWIU8CPU7mtSPXXM8QUzQexWdpyfqs0u6OjiMSKhaviyOHymFqDLu
         Bhd69ulE9Nwvf8xmvFCLRQFLcEYnUlIpM5ILurfACcNacMsV3kykipeKQkgW17/QlYWQ
         KEhA==
X-Gm-Message-State: AOAM532yly9Lm+7U7Er0/fa8fKPWBzAbTQeoTQEhlvCphoqVKyXJsieO
        mIvLWdXmA5XeDNmWKWtJ+x/hqLt8wgtnxxPoIQQb5A==
X-Google-Smtp-Source: ABdhPJxhKAUyCkkPAjGWEELWh3qbbbzQYB5MSQk5Ht/V6TTVpoiQIzNDZ4iAXo0PDGcIqt8h6lJKcUanUp/MHHUasws=
X-Received: by 2002:a05:6512:1155:b0:471:4c94:97c with SMTP id
 m21-20020a056512115500b004714c94097cmr13816995lfg.338.1650503291055; Wed, 20
 Apr 2022 18:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <CANXhq0r15Z9NZj+xr7K_2Tt5VbK2r4+f7Fpg-f9BY98ufgKxcw@mail.gmail.com>
 <mhng-75e55594-c878-4fad-9ffc-dc552111208e@palmer-ri-x1c9> <CAL_Jsq+5TbfFxD3p4ckvNw=jFweuvjQPRQfjmvPqZJga25o0pA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+5TbfFxD3p4ckvNw=jFweuvjQPRQfjmvPqZJga25o0pA@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 21 Apr 2022 09:07:59 +0800
Message-ID: <CANXhq0rYBCQyGK-zfKdU51y03dSD9XsPwtCqg8a7xvxYV3LL+A@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Determine the number of DMA channels by
 'dma-channels' property
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Vinod <vkoul@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bin Meng <bin.meng@windriver.com>,
        Green Wan <green.wan@sifive.com>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 20, 2022 at 10:26 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Apr 19, 2022 at 7:18 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > On Mon, 11 Apr 2022 04:43:35 PDT (-0700), zong.li@sifive.com wrote:
> > > On Mon, Apr 11, 2022 at 6:48 PM Vinod Koul <vkoul@kernel.org> wrote:
> > >>
> > >> On 11-04-22, 10:51, Zong Li wrote:
> > >> > On Fri, Apr 8, 2022 at 9:13 PM Vinod Koul <vkoul@kernel.org> wrote:
> > >> > >
> > >> > > On 28-03-22, 17:52, Zong Li wrote:
> > >> > > > The PDMA driver currently assumes there are four channels by default, it
> > >> > > > might cause the error if there is actually less than four channels.
> > >> > > > Change that by getting number of channel dynamically from device tree.
> > >> > > > For backwards-compatible, it uses the default value (i.e. 4) when there
> > >> > > > is no 'dma-channels' information in dts.
> > >> > >
> > >> > > Applied patch 1 & 4 to dmaengine-next, thanks
> > >> >
> > >> > Hi Vinod,
> > >> > Thanks for your help and review. For patch 2 and 3, does it mean that
> > >> > we should go through the riscv tree?
> > >>
> > >> Yes
> > >>
> > >
> > > Hi Palmer,
> > > Could you please help me to pick up the patch 2 and 3. Thanks :)
> >
> > Sorry about that, I forgot about this one.  I just put them on for-next,
> > there was a minor merge conflict but it looks pretty simple.
>
> Looks like you applied patch 1 too which Vinod already applied to the
> dmaengine tree. And you changed the 1st line removing the "# " before
> the SPDX tag which results in:

Hi Palmer,
Many thanks for helping me to pick them into riscv-tree, It seems like
we need to pick patch 2 and 3 in riscv tree, instead of patch 1 and 2.
:)

>
> make[1]: *** Deleting file
> 'Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.example.dts'
> Traceback (most recent call last):
>   File "/usr/local/bin/dt-extract-example", line 52, in <module>
>     binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py",
> line 434, in load
>     return constructor.get_single_data()
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py",
> line 119, in get_single_data
>     node = self.composer.get_single_node()
>   File "_ruamel_yaml.pyx", line 718, in _ruamel_yaml.CParser.get_single_node
> ruamel.yaml.composer.ComposerError: expected a single document in the stream
>   in "<unicode string>", line 1, column 1
> but found another document
>   in "<unicode string>", line 2, column 1
> make[1]: *** [Documentation/devicetree/bindings/Makefile:26:
> Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.example.dts]
> Error 1
> ./Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml:1:1:
> [error] missing document start "---" (document-start)
>
>
> Rob
