Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3170566D949
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jan 2023 10:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbjAQJGW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Jan 2023 04:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbjAQJGE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Jan 2023 04:06:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC7931E0E;
        Tue, 17 Jan 2023 01:01:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03ECF61217;
        Tue, 17 Jan 2023 09:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF6EC433D2;
        Tue, 17 Jan 2023 09:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673946087;
        bh=RCqS3nTyPkoxO7ZgcJfu9N4L+LZ0ONOPuzr2k9qjISQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FkCrXu2S+1A1LDVxNCS5+xHeZHRBD/hPas8S+cZAzq87aik5vDzUHfek1aExKUYG2
         4cLnizoYvBZ8UTvrXhFvvY/Y3JSN7RDbqG3DyliHUkuPY3zEc33NQ72yJdebftB6/W
         +PimfIQl4s4r+wrNwe5PSlopBk0HnsO2U5eHyfVVjMUgqo1GOvWXe3FZUsW5kz4X+5
         73jXdNBRMEgbvl+D3zgKGrNDPp0+DwSkS5ERfasgJdDoYeEUzw+Xy+GIc9K5voPO6C
         JBIX9YLHsm06Il8v+RbUAIVMAxKqsbWU/HRce4Jm0oYCKyLmgB5m7a4gk9sEnG67ev
         Y94cCcL30viaw==
Date:   Tue, 17 Jan 2023 14:31:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     peter.ujfalusi@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: ti: k3-udma: remove non-fatal probe
 deferral log
Message-ID: <Y8Zj41+ljmIq3duz@matsya>
References: <20230117051855.29644-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117051855.29644-1-j-choudhary@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-01-23, 10:48, Jayesh Choudhary wrote:
> Drop the non-fatal probe deferral log for getting MSI domain.
> This makes the kernel log clean and we do not get recurring logs
> stating: "Failed to get MSI domain".

Applied, thanks

-- 
~Vinod
