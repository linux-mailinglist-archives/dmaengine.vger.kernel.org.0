Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74279246B2
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 06:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbfEUEXt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 00:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfEUEXt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 00:23:49 -0400
Received: from localhost (unknown [106.201.107.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C20762173E;
        Tue, 21 May 2019 04:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558412628;
        bh=iudBiK01SUQ2p4NuFMI5bC8tmBFWPu3Vq2L64tG8Jjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQ5nN2KYdUR9+HZDvFsNh0PRh31JFRB4xiLf6v9pfCFCtJkLXGuHJcgUiQa9xqHgW
         pWBlE9hTnovD0X018ZI0drBZChqV62naI2W062Fj4iEI51sVwtI+ILJSLtiztlnfa9
         eWG42uKgsbBd47DDNmYkmTEbZ3aC8leGon3QcV+k=
Date:   Tue, 21 May 2019 09:53:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Simon Horman <horms+renesas@verge.net.au>
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] dmaengine: sudmac: remove unused driver
Message-ID: <20190521042344.GH15118@vkoul-mobl>
References: <20190513113951.14817-1-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513113951.14817-1-horms+renesas@verge.net.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-05-19, 13:39, Simon Horman wrote:
> SUDMAC driver was introduced in v3.10 but was never integrated for use
> by any platform. As it is unused remove it.

Applied, thanks

-- 
~Vinod
