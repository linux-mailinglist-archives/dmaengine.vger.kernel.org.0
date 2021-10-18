Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D61F431034
	for <lists+dmaengine@lfdr.de>; Mon, 18 Oct 2021 08:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhJRGOb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Oct 2021 02:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229847AbhJRGOa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 Oct 2021 02:14:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34DC760F56;
        Mon, 18 Oct 2021 06:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634537540;
        bh=ldV0jLsQM2JKFvHcaaUIILtmSHrDJOrZau0L8CFH6ZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rjVrxCgz1EuWzXvlAWSEUtehR3a8uyS8Zf9lzNtqN2LwIxIk2mDOIio4EnYQ2HIXN
         d8bPg5kjYN/wKYXtqUwHxp0wpHs4GspzE11nvbWkkY3wUo4i7a7Ut+fnHV2qlsTck+
         NPRMzTKSteRp1l+isU7LmOa5WOvtfStKE8MRKekhjpGLdcF3pMhQCfWLVzk4Jf/N7X
         AisxDgZhtACqX/RVmevunWHFrzJMaCGntcf2RZreXE4fKxURBVcMqx96XxsuFYT1Do
         MHbQ0QY2LCsUPtUlqLtzpDEET+VzVBHT4uVjXyzYo2YnRFK5BTz0g/Rz0MfKnlKTVm
         Ya8yhxj1lCb6g==
Date:   Mon, 18 Oct 2021 11:42:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     ludovic.desroches@microchip.com, tudor.ambarus@microchip.com,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] dmaengine: at_xdmac: fixes and code enhancements
Message-ID: <YW0QPwmB2BNQb7Bl@matsya>
References: <20211007111230.2331837-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007111230.2331837-1-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-10-21, 14:12, Claudiu Beznea wrote:
> Hi,
> 
> The following series adds some fixes and code enhancements for at_xdmac
> driver.

Applied, thanks

-- 
~Vinod
