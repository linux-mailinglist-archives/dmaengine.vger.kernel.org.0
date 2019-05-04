Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3B75138AA
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2019 12:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfEDKVO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 4 May 2019 06:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfEDKVO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 4 May 2019 06:21:14 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 718F420675;
        Sat,  4 May 2019 10:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556965273;
        bh=rQTWEeZZ9og7kvu5nLySRWym5zK+gidejdVifNmQJmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T5PsgJllpDgabG60xxfaFbbCrFtJkz55oU0/QPZxaqCOGx/FwcEo2Rgg1ZiOfk6OW
         WE8NYGRJ6ZYGDjE9RMMSIH85y1T0FxfdpcXLtpRILVRoT1vPV1ptpoaxxZnDeA3gmy
         R4/M9+gdaMDLQdjHw5dicOxmFiP9+CPeckPLfIK8=
Date:   Sat, 4 May 2019 15:51:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: fsl-edma: Fix typo in Vybrid name
Message-ID: <20190504102101.GY3845@vkoul-mobl.Dlink>
References: <20190504095225.23883-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504095225.23883-1-krzk@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-05-19, 11:52, Krzysztof Kozlowski wrote:
> Fix typo in comment for Vybrid SoC family.

Applied both in the series and ignore the (3rd?) usb patch! thanks

-- 
~Vinod
