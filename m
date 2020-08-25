Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF09251724
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 13:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgHYLKE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 07:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHYLKD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Aug 2020 07:10:03 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 650732071E;
        Tue, 25 Aug 2020 11:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598353803;
        bh=w30OqiibvtacniwjHg2viVJ3Iyg7WO59WpSOlIJFLLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=boGXDU8Wk/NYRwIb8BenXAZhIhVMJ7lwrQhsKS8NF3joV5PwcvK+G2ndNujsY1lMn
         JWgwTZ3QOu4lS+3ClbV7wxS52PVFtFCbiSK7ufrbEGIQZUHX5S1gvIUFPWFeduQJFt
         9cPplCGFo/ZwewhnrNLo86+HKc+wOaiHIBMFZ+uQ=
Date:   Tue, 25 Aug 2020 16:39:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     dmaengine@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] dmaengine: dw-edma: Fix typo in comments offset
Message-ID: <20200825110959.GJ2639@vkoul-mobl>
References: <d7c7e56a83a13a62438a6c1a23863015a3760581.1597327654.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7c7e56a83a13a62438a6c1a23863015a3760581.1597327654.git.gustavo.pimentel@synopsys.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-08-20, 16:14, Gustavo Pimentel wrote:
> Fix typo in comments offset related to padding bytes.

Applied, thanks

-- 
~Vinod
