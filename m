Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85B43E0DD7
	for <lists+dmaengine@lfdr.de>; Thu,  5 Aug 2021 07:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhHEFlH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Aug 2021 01:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230405AbhHEFlH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 5 Aug 2021 01:41:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A744760F42;
        Thu,  5 Aug 2021 05:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628142053;
        bh=nDDYvzK7uOjy5ivPZUduSoVJ8F8p48f4un4ntWwQP8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ascmbzI5EqnXsCd/6UpIQPeOyO96TwF3tzoyEuR1jkZqJhR/t7v32EspCdvc0pAkp
         tr1sASZ0Kfj3phBN2K3Dq/tNVaslQRXrjezKFOGmKv2+Srka/cmL8qCVXXeJMdhZWf
         1MNpvAxzVCUvwL2wxnhQTzfQjLB6M9oGMwd507a/d5tmvnbze2jJLd+qnYVZQCFbzi
         mkdHn1cHovZOLbQY9gddhrftlzGOcRdIQWBt0oLNkMLmyrS5qPV390QgUN05eAqxvq
         XqGwVa3UlYLSlgkiof5VevwSj2WNuo+5C93jOUx7Pgt45bqHrh0vDF9c3dvMFiya4O
         ud5FMx9X3Zeww==
Date:   Thu, 5 Aug 2021 11:10:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <sanmehta@amd.com>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v11 0/3] Add support for AMD PTDMA controller driver
Message-ID: <YQt54U70927eUgr3@matsya>
References: <1627900375-80812-1-git-send-email-Sanju.Mehta@amd.com>
 <649e5d7b-54ba-6498-07e8-fa1b06a25fc2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <649e5d7b-54ba-6498-07e8-fa1b06a25fc2@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-08-21, 16:06, Sanjay R Mehta wrote:
> 
> 
> On 8/2/2021 4:02 PM, Sanjay R Mehta wrote:
> > From: Sanjay R Mehta <sanju.mehta@amd.com>
> > 
> 
> Hi Vinod,
> 
> I have fixed all the review comments suggested in this patch series.

Looks like kbuild-bot is not happy, pls fix the issues and submit a
fixed patcheset

-- 
~Vinod
