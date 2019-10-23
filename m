Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3E4E1182
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 07:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732944AbfJWFPH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 01:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728697AbfJWFPH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Oct 2019 01:15:07 -0400
Received: from localhost (unknown [122.181.210.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30AA4214B2;
        Wed, 23 Oct 2019 05:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571807707;
        bh=NSP5YHXNLaXyRHpxdaRvfUgyBpL8uBQa0WGnzY8pm0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YkAVFsBjDO6oumrJtx4ytUMuTnFS5lKv0WgSSX+skgmzxhviGrhyYsV2bIgIMaHdp
         C0dDdecNWu3Mwipm6YDQNbANc0S03iIURXQjKuO1RCzbHitT7APyppyZtin+xpeyjH
         DVt6+W666/SkHTYzE3C7YWCDJ/M/37IDrOkz+41Y=
Date:   Wed, 23 Oct 2019 10:45:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, paul@crapouillou.net,
        mark.rutland@arm.com, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com
Subject: Re: DMA: JZ4780: Add DMA driver for X1000.
Message-ID: <20191023051501.GQ2654@vkoul-mobl>
References: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-10-19, 11:05, Zhou Yanjie wrote:
> 1.Add the DMA bindings for the X1000 SoC from Ingenic.
> 2.Add support for probing the dma-jz4780 driver on the
>   X1000 SoC from Ingenic.

The subsystem in dmaengine and not dma

Please resend with correct tags!

Thanks
-- 
~Vinod
