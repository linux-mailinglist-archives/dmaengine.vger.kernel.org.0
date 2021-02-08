Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBD73131E0
	for <lists+dmaengine@lfdr.de>; Mon,  8 Feb 2021 13:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhBHML4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 Feb 2021 07:11:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhBHMKs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 8 Feb 2021 07:10:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BAAE64E60;
        Mon,  8 Feb 2021 12:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612786207;
        bh=nmgMPA9aG9SEGs9aCSG8Q2Nt83p49YoOTOJMXeC5rwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iXaoCKpbW6taMiwTuh+OTTaQPezm9nGCpJf1k+E1zNdz5aOCnbC5piA9IxPDl2aoE
         ae9L6qeiXNfPEaQwnzQkjEqBmIsYkMSWSGe4HbyIeulaiGnSQ6JUyeLwB9pJmOvl9o
         Xac9ULfyYOk9IduuKHgDX7cM0Ng5cpipe3O4jxjAXLb2O9rRN8dN4LqhZnnbSPl/7v
         y23aOPp9Re3Xfvv0QUXrid5D/EwL9IuQqokepoiLmrQ17YN6OcqpMiuid6p9K7lvKS
         oXPg6fSIC628udwVgApXTUcVipF4P0t3zqRwbdf3anAj+vjWLhfwhC+Ytj7lacUIwf
         /FxqSeinS6u3A==
Date:   Mon, 8 Feb 2021 17:40:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] dmaengine: dw-axi-dmac: remove redundant null
 check on desc
Message-ID: <20210208121003.GE879029@vkoul-mobl.Dlink>
References: <20210203134652.22618-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203134652.22618-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-02-21, 13:46, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer desc is being null checked twice, the second null check
> is redundant because desc has not been re-assigned between the
> checks. Remove the redundant second null check on desc.

Applied, thanks

-- 
~Vinod
