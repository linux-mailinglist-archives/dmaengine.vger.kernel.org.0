Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1715B507D83
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 02:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245126AbiDTAVR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 20:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiDTAVQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 20:21:16 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976B12611F
        for <dmaengine@vger.kernel.org>; Tue, 19 Apr 2022 17:18:32 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 203so22708pgb.3
        for <dmaengine@vger.kernel.org>; Tue, 19 Apr 2022 17:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=8m4sLnpIyX8zfbZGZxaNokmhKJeRbQ/UL/T2dqn4Rj8=;
        b=pAYUjQl3HCJWsKHJvSQYrl2vBnKRybBJ+y2Yzmpe4MvOmhVKXYperLQgIRLk3PIURT
         xgVQubCGf36IfmhtxuycN8I3OZVyNRRrliG4hfdxKyjV3e0EhvY84yPdh6UwnXa21pa9
         wggfK7z/v+f1ZmgViXBnVqzpso+C/MdHcsEFwWwHHB9nE6WWvwtPvpQXTXgW/UwYrKGE
         oWaHl2Ah5zVVeZy4PiBjfAjA9L7du677k8lzXbDB5L2jxvrXJ1QfKWROEzDX4//yrJWi
         qAGVxDTG15yPdbqxKjlrxHP3VvJzCqluAvCqHhwAjD0I4WzJdk1drjN6bVq4o4bNBO3d
         Gokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8m4sLnpIyX8zfbZGZxaNokmhKJeRbQ/UL/T2dqn4Rj8=;
        b=THlqeU3kxxfaD5bUSPYuVuHlnVfLbQ/lOVDy2wKqScJYsPZVBdP+JClAd2eYSt4soj
         gE7lT7FM28YoO8vYhqbo1GX9lPS6qnJSpO2BbT4DvkJ+Il/Se2aKa+8FiqtD7aPMyiD+
         +xOZgAHILE8Jdh7xLUyisuVEAswrXX7PN84/4MlRZUnAqNMW6CnsQYVeSDkvvg8R1opY
         AaptjZV4Mp5Os9c9QQNibh7y+DHDNFzLB00zIVKp5nkVr3Oi24cViL/QCo8Pwwa06cDz
         /6KhKVoAOiS+SSMeCr2CEF/Hufek6uDRckUdLqMz04GrTbQTUZFbp6VH1Oy1+43ScPK2
         1OAA==
X-Gm-Message-State: AOAM532KWgYG8zZNWInbNqQ08YUKDeZbA8Rj5EFephgTfHACXAmd01g1
        CigFUs7iD5rXIDOXemQxg9/OIA==
X-Google-Smtp-Source: ABdhPJzY30m2JkFKvX9I7BrqiPAWeGK36jJzZMp7MhX7R9X0+P+aJW7JuRPGYNhm3Y9AWkoV3ONSYA==
X-Received: by 2002:a05:6a00:890:b0:4f6:686e:a8a9 with SMTP id q16-20020a056a00089000b004f6686ea8a9mr20500588pfj.83.1650413912043;
        Tue, 19 Apr 2022 17:18:32 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id a133-20020a621a8b000000b0050acaab7b29sm156609pfa.31.2022.04.19.17.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 17:18:31 -0700 (PDT)
Date:   Tue, 19 Apr 2022 17:18:31 -0700 (PDT)
X-Google-Original-Date: Tue, 19 Apr 2022 13:28:36 PDT (-0700)
Subject:     Re: [PATCH v8 0/4] Determine the number of DMA channels by 'dma-channels' property
In-Reply-To: <CANXhq0r15Z9NZj+xr7K_2Tt5VbK2r4+f7Fpg-f9BY98ufgKxcw@mail.gmail.com>
CC:     vkoul@kernel.org, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        geert@linux-m68k.org, bin.meng@windriver.com, green.wan@sifive.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-75e55594-c878-4fad-9ffc-dc552111208e@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 11 Apr 2022 04:43:35 PDT (-0700), zong.li@sifive.com wrote:
> On Mon, Apr 11, 2022 at 6:48 PM Vinod Koul <vkoul@kernel.org> wrote:
>>
>> On 11-04-22, 10:51, Zong Li wrote:
>> > On Fri, Apr 8, 2022 at 9:13 PM Vinod Koul <vkoul@kernel.org> wrote:
>> > >
>> > > On 28-03-22, 17:52, Zong Li wrote:
>> > > > The PDMA driver currently assumes there are four channels by default, it
>> > > > might cause the error if there is actually less than four channels.
>> > > > Change that by getting number of channel dynamically from device tree.
>> > > > For backwards-compatible, it uses the default value (i.e. 4) when there
>> > > > is no 'dma-channels' information in dts.
>> > >
>> > > Applied patch 1 & 4 to dmaengine-next, thanks
>> >
>> > Hi Vinod,
>> > Thanks for your help and review. For patch 2 and 3, does it mean that
>> > we should go through the riscv tree?
>>
>> Yes
>>
>
> Hi Palmer,
> Could you please help me to pick up the patch 2 and 3. Thanks :)

Sorry about that, I forgot about this one.  I just put them on for-next, 
there was a minor merge conflict but it looks pretty simple.

>
>> --
>> ~Vinod
