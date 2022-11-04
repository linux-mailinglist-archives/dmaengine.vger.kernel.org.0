Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF1B6198CB
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 15:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiKDOHM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 10:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiKDOHB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 10:07:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8324925293;
        Fri,  4 Nov 2022 07:06:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29B65621E0;
        Fri,  4 Nov 2022 14:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0384BC433C1;
        Fri,  4 Nov 2022 14:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667570816;
        bh=eE2jVlsFvvjO83PjQRCw64Q67TM1093yScgeyUeBiKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=omL6ZxcxMYeFHkdDV2x7lWHt7K9rD330lDDVFF+e3qpNDJcTHl7fTWHOlofufGsbn
         nN7v/XvSAZjN/RZWKd6efxUAY41zOto24imq9OA7lmpHgVh3y9ZxbwndNvaA19F7WQ
         cLPfzDc/wreqDwa8Zwi+vO59QaN12rVaKJDj2JvC9C/Icv7IxwIfMe5UnuDd2ARW9y
         hK+H/YSnnMTTaKrumPS0A+LZmTT9B4o3EpopAcsFKO75JbNV6NZSnE6MTqD4dZVMtX
         6gb22jTzSmmffPM2DYCyKl1dfuoy//E5M1iHwE+cTt9mjxjx/uZCmKJ8EhWlYz7ovr
         YlnXqUySdwwBg==
Date:   Fri, 4 Nov 2022 19:36:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: remove section INTEL IOP-ADMA DMA DRIVER
Message-ID: <Y2UcfDxYQgsqiiyC@matsya>
References: <20221020082103.29218-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020082103.29218-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-10-22, 10:21, Lukas Bulwahn wrote:
> Commit cd0ab43ec91a ("dmaengine: remove iop-adma driver") removes the
> driver's source code, but misses to remove the MAINTAINERS section.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken file pattern.
> 
> Remove the INTEL IOP-ADMA DMA DRIVER section pointing to the removed
> driver.

Applied, thanks

-- 
~Vinod
