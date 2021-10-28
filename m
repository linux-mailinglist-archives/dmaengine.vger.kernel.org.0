Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481E043E710
	for <lists+dmaengine@lfdr.de>; Thu, 28 Oct 2021 19:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhJ1RY6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Oct 2021 13:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhJ1RY6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 28 Oct 2021 13:24:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC10C60C40;
        Thu, 28 Oct 2021 17:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635441750;
        bh=F5w6OeGLCr6LMebPNE+Mj5H+2u11p9J1ZK4ZjFCo6XU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rqWcERGVXEUBTMqZ5bwzGxfoOQXhmM9JT/fMJfiWFGJ7kO6a+ntvNNoOFOiMkUpmb
         qAoxhLa1OnTbvmevdK42yUPtFVQpJU8IvYUqQmczAm2pvPwi+Frsll3CaBHYbbAnC9
         63IRnu7bIPxROOSE69BoKYshHbLKELzy0Vz1icWKeQ3BtSc3AM95tUQKWLcKrk5RGi
         6cAN1mMp/jx6ubKHL1fU7IWG+WuCdOhCglcdVAvHvfIA/681c2bLsxpf4vWBKpXh3U
         chR//QIN3W2oHYlKnqHQdXUndNjfUlWbD6k4M3hkI3ozvwAPDhLB7yITwCXDarXY3k
         p7k96AB4vdATw==
Date:   Thu, 28 Oct 2021 22:52:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     ludovic.desroches@microchip.com, tudor.ambarus@microchip.com,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] dmaengine: at_xdmac: fix compilation warning
Message-ID: <YXrcUrNCH4gO9+yO@matsya>
References: <20211025074002.722504-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025074002.722504-1-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-10-21, 10:40, Claudiu Beznea wrote:
> Fixed "unused variable 'atmel_xdmac_dev_pm_ops'" compilation warning
> when CONFIG_PM is not defined.

Applied, thanks

-- 
~Vinod
