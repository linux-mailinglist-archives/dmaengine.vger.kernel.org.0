Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7D6048A7
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 16:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJSOFR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 10:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiJSOD5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 10:03:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A846AE4E50;
        Wed, 19 Oct 2022 06:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECABD61808;
        Wed, 19 Oct 2022 13:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98495C433D6;
        Wed, 19 Oct 2022 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666187015;
        bh=3tLWceL0lc++Vby6ut1Ss2Tw8U1MEyYfWNczXMjJzTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hq48gC8aF1IZimQJQc0GyAy8tl7LO7Z2KuAx5bCPFbs/bOz2QduHmSCyvZqn6d4jN
         47ukCLApElArcX+i8DPaIjc+fVKcdxzyvt/ds1ye5ldNVJ100MJ9YzlF1zfv3HyDaV
         fg4UN9SqDqFCy+f+s+bDG95GDQ7fYX0UnQmTzAbecexMsuibF7e9LhSPGN7UIQ7zDA
         ukjxpP54igJR0WKOmEYknJHjjo0MFUGQYHS897CCu4Z4IXlLX8XFaObNJLDL3yd7yZ
         k7Z6W18594s3LNrp/OHR5vgGDb02MM/3SwKizqKIzN+aQxpnv2axGYkQD/vgQEyCOe
         K5Re4oOI12eTw==
Date:   Wed, 19 Oct 2022 19:13:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add Ingenic JZ4755 DMA support
Message-ID: <Y0//Avs6iCQatoWV@matsya>
References: <20221018181219.3251309-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018181219.3251309-1-lis8215@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-10-22, 21:12, Siarhei Volkau wrote:
> This patch serie adds JZ4755 SoC DMA support.

Applied, thanks

-- 
~Vinod
