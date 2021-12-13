Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D304720EE
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 07:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhLMGGy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 01:06:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48400 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbhLMGGx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 01:06:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1AA5B80D7C;
        Mon, 13 Dec 2021 06:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB66C00446;
        Mon, 13 Dec 2021 06:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639375611;
        bh=51XhMkIPpjD7Sz/KLBJL9LCG1cdPx1zpRsb6s/TO8wY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KPX+6g++lKx0OEHyuDpZ7Qa5HYMaB+tk4msYyZ1cgq06UZsCzIRLbSLLmSIfXTmIc
         vFZ5MWQtUOlI8MidSb3mxKh3L7mtWAnEaKhHO/Qz2W3GN02XiDMoEFLOXn5Shpsp0E
         JqplpyB2nqYM37tSLh7MhzD8o/psbxIJJWC/VBPnoXyMRDZt8svCPcdPiTj4HVNAst
         VbFSCAKjiIigw3l+4e691ohozASDVzV8+JuSX9bNLcZ6vv7n2yYp21fH45yRx6fp2j
         2958BrqT2mT/0vt9mB89qf6eP3Z6/bAup9XFYmEJPKfrYsm838xLrPo/zsEKhAYqy0
         zQCOj8hFg69IQ==
Date:   Mon, 13 Dec 2021 11:36:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: ti: Add missing ti,k3-sci-common.yaml
 reference
Message-ID: <Ybbi9+6Dhca9SOOd@matsya>
References: <20211206174226.2298135-1-robh@kernel.org>
 <Ya8eC9UkwMZaNozs@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya8eC9UkwMZaNozs@orome.fritz.box>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-12-21, 09:40, Thierry Reding wrote:
> On Mon, Dec 06, 2021 at 11:42:26AM -0600, Rob Herring wrote:
> > The TI k3-bcdma and k3-pktdma both use 'ti,sci' and 'ti,sci-dev-id'
> > properties defined in ti,k3-sci-common.yaml. When 'unevaluatedProperties'
> > support is enabled, a the follow warning is generated:
> 
> s/a the following/the following/
> 
> Otherwise looks good:

Fixed up while applying..



-- 
~Vinod
