Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88DF7193901
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2020 07:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgCZGxy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Mar 2020 02:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgCZGxy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Mar 2020 02:53:54 -0400
Received: from localhost (unknown [106.201.104.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A60E206F8;
        Thu, 26 Mar 2020 06:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585205633;
        bh=ufATkhGdJw2R1PLs3HU1B0oeXOIhfK2e9fgG659urEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GKXPmpmtIPmj82IWpJAyaCAbp/Ew038QxByAG0AnjkcwhyX5Cp709nsp1RgiI/OsW
         Sa7/L4hUfRa527pd3CvGCY9p8xSGUbyiNNdLvU5mZiYXqHHc6aF3Fk88Y0ciN+Agn6
         DqpREywp2kMxdeS1agpkXckhjJ1rFuqTKQZvhKFM=
Date:   Thu, 26 Mar 2020 12:23:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     robh+dt@kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: renesas,usb-dmac: add r8a77961 support
Message-ID: <20200326065348.GV72691@vkoul-mobl>
References: <1585117138-8408-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585117138-8408-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-03-20, 15:18, Yoshihiro Shimoda wrote:
> This patch adds support for r8a77961 (R-Car M3-W+).

Applied, thanks

-- 
~Vinod
