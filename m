Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B85795CF4
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2019 13:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfHTLLE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Aug 2019 07:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbfHTLLE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Aug 2019 07:11:04 -0400
Received: from localhost (unknown [106.201.62.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D30922CF5;
        Tue, 20 Aug 2019 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566299463;
        bh=BDOyWFL5FVrAqfKh2ThO7wIJi8uan6S8AtmMcPPAw2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fnDufINExG683jwKFvcc3IFGdNSf+ctvWzQJsPD/LtYYC6R//AbNNhw5mZEcg2AtZ
         LAVWHswnDhR6JBBgFvkwI2DvqjwmmSBUAvZ8wnSrYUo3seyi3gdWItj1BpjO1Fh7XM
         ee8m+/NUb32DzXUuqXsI0oe5aRyhhocMMQpSGeN0=
Date:   Tue, 20 Aug 2019 16:39:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] dmaengine: dw: Update Intel Elkhart Lake Service Engine
 acronym
Message-ID: <20190820110952.GS12733@vkoul-mobl.Dlink>
References: <20190813080602.15376-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813080602.15376-1-jarkko.nikula@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-08-19, 11:06, Jarkko Nikula wrote:
> Intel Elkhart Lake Offload Service Engine (OSE) will be called as
> Intel(R) Programmable Services Engine (Intel(R) PSE) in documentation.
> 
> Update the comment here accordingly.

Applied, thanks

-- 
~Vinod
