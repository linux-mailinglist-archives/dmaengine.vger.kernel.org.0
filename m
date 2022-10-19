Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7BB604DF6
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 18:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiJSQ51 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 12:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiJSQ5C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 12:57:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9811D102F;
        Wed, 19 Oct 2022 09:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB9436195A;
        Wed, 19 Oct 2022 16:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF17C433D6;
        Wed, 19 Oct 2022 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666198603;
        bh=Gx+yBjw/cHq8qIIiw/IyPDqfSAWDQNNm8s3u2fpj0OM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y5FOV7bSi4DuLF5boJt0FWMoRF9/YnZ4yoSb0ywl65JbQDmHUbDsBkVZqOHy+FU6S
         8EBmABxExf4Yj5PGxd4iy3GX8qD333vIRU6/trPVJM/CjgvN+0zLzmqYjI2kJMDv/z
         OAsx/gtiaekHlpqURE8k3wfJaDFv/gFaZU0jP0Dr4PmMJ3QcrTeOgf9vlentvdMZLY
         MbjRtS8zkswYlzgmm7FZENb+g1RLd6jW4q3K7jZd/8coLkoJDiC4SNo286WEgZFbnS
         Yv0jOYJF2FouQP7Fv9W9SgiG40KLlENqKqaeAQheQJeDAsBJ0IxVBKkY6nfX5DY3Ho
         0+0PNmbS21Igg==
Date:   Wed, 19 Oct 2022 22:26:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 10/17] dmaengine: remove iop-adma driver
Message-ID: <Y1AsR+8pZssD7y2b@matsya>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
 <20221019150410.3851944-10-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019150410.3851944-10-arnd@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-10-22, 17:03, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The iop32x platform was removed, so this driver is no longer
> needed.

Applied, thanks

-- 
~Vinod
