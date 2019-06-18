Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1AA4A1AD
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2019 15:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfFRNHo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jun 2019 09:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRNHn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 18 Jun 2019 09:07:43 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70BC12084D;
        Tue, 18 Jun 2019 13:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560863262;
        bh=VE0S7GCn+EbKWsC3UJVmk1yL5T1BYtNXt8mSBrOsjTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9bZq/JS3pwdAUtsp5oTPoUmzKUchwKyZg1vrEy+xOf3mOKf4mfP/9SvqEhaw6FoU
         I5H170T2bQGUl9j3fkhLb7VmSnoFzEuHASNL0r2EhTQhyJe1EEQZ2UhKsHKPfGdZnJ
         O0Hr2N9D9pevumRJhlHXpaKu4y4s58hSmnSJKPOo=
Date:   Tue, 18 Jun 2019 21:06:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] arm64: dts: fsl: ls1028a: Add qDMA node
Message-ID: <20190618130634.GA1959@dragon>
References: <20190506090344.37784-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506090344.37784-1-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 06, 2019 at 09:03:41AM +0000, Peng Ma wrote:
> Add the qDMA device tree nodes for LS1028A devices
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>

Applied, thanks.
