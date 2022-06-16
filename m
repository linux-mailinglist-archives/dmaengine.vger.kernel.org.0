Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF7654E2AD
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 15:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377393AbiFPN5w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 09:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377352AbiFPN5h (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 09:57:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF01CD0;
        Thu, 16 Jun 2022 06:57:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48E8EB823C4;
        Thu, 16 Jun 2022 13:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5616C34114;
        Thu, 16 Jun 2022 13:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655387847;
        bh=7OGNMTwV/KFRHTVu5XLpdbkyVzZASMOM/AiJOgjfH0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADTKtU0M4BMysZHUWVTX6MILWsaoSnp2ganp0Mdr2spIMzSfITiAbGnHuQ5QTpzAY
         WxADUUDkxr2aywRH8sPIdjcNYhO3FvCxvfkr8HKMhQCtz4AfqCs4cLGcvO+QkDlMX9
         9RVePZuXTELG5kx0Ln/BROb2FEhItNzc2CKDF8yp2c/NUNtpiQWBLVALnTXCq0mGWD
         VzY86WCRoNKbY2IRMjC4QNOlBmXBBRVi+kr/lD+yzaTBKOWuJSc7IhHoxz/vD6LlEa
         x0SqzrPZUL1Ug6cAwfgAMJ4s/9i6bTPSivAVeohwjQCzEFmeLa5cv9E20Bu6SYBR5R
         /cAmJ8zDISJzQ==
Date:   Thu, 16 Jun 2022 06:57:27 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: apple,admac: Fix example interrupt
 parsing
Message-ID: <Yqs2x+BPbCxJvI6I@matsya>
References: <20220614152503.1410755-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614152503.1410755-1-robh@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-06-22, 09:25, Rob Herring wrote:
> Commit 873971f8fb08 ("dt-bindings: dma: Add Apple ADMAC") has a warning
> in its example:
> 
> Documentation/devicetree/bindings/dma/apple,admac.example.dtb: dma-controller@238200000: interrupts-extended: [[0], [4294967295, 0, 626, 4, 0, 0]] is too short
> 	From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/dma/apple,admac.yaml
> 
> The problem is the number of interrupt cells can't be guessed when
> there are empty '0' entries. So the example must have a valid interrupt
> controller defining the number of interrupt cells.

Applied, thanks

-- 
~Vinod
