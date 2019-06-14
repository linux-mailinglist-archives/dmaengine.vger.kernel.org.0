Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F28045460
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2019 07:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbfFNF4r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jun 2019 01:56:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfFNF4r (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 14 Jun 2019 01:56:47 -0400
Received: from localhost (unknown [106.201.34.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68D1620850;
        Fri, 14 Jun 2019 05:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560491807;
        bh=PNG8AIxk4SHrWwNBgkqCo3sTIKT4E4fcTwXYu2QOBSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y4sV6MTItOq6vzrswNUU4V//i2gRD5QT61Ni4cThO9RH+vonrSPR1Eu3ldtQkTAFH
         rzVMofUaaxvX7tkAZ76DvW8zf7nbAN1srPwCt1nUf2Ae6j3RSe4aGf2SOMoJhvT0YU
         oIeyptRDwSkM86C0CDey0sf+m14p1NbMzohJGzz4=
Date:   Fri, 14 Jun 2019 11:23:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/4] dmaengine: virt-dma: store result on dma descriptor
Message-ID: <20190614055337.GD2962@vkoul-mobl>
References: <20190606104550.32336-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606104550.32336-1-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-06-19, 13:45, Alexandru Ardelean wrote:
> This allows each virtual channel to store information about each transfer
> that completed, i.e. which transfer succeeded (or which failed) and if
> there was any residue data on each (completed) transfer.

I fixed the style issue while applying and whole series is in -next now

Thanks

-- 
~Vinod
