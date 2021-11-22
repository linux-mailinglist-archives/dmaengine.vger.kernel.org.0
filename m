Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131D8458987
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 08:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhKVHEx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 02:04:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:38082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231159AbhKVHEx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Nov 2021 02:04:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A07DA60F24;
        Mon, 22 Nov 2021 07:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637564501;
        bh=GkbsbrlWt/T8Pi3AbU37pEU96BqbCu/1FEDOBMKKOt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TE4PCoPsHDMgPCcYTUJPyC+PeNLqFKUdZZxQuDy1K9L8NJUN3e9HN4onUox7PX9h9
         v8M8g3EygnzOiXWfwJvUFPz+JPF420IhGHbDWdiqbaLrqGa5wlb14GB/9u59P7lIkq
         ZRA0tnBmEtQDCFb+08dlTdWu7tRFrgFb3d+w9O1ySwavUTnn+yvEJreD3Xhy8Mn1hD
         +rreLr45BDG41gVMFjDO1a9xL0Sj6yCeB4EUJtmG+wPcplOybF4AsmcI9tO3GkYLdV
         AqIu8ZQ8c4yOPeDI4QBBtzYlMtxMrGHvQLFJWxpbEe08e1D6nTSQuDME1KYQsSMpA0
         QJlS9eMDo3NhQ==
Date:   Mon, 22 Nov 2021 12:31:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@linaro.org
Subject: Re: [PATCH 0/2] Documentation: dmaengine: Tweak dmatest docs
Message-ID: <YZtAUGP+stQEL1iO@matsya>
References: <20211118100952.27268-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118100952.27268-1-daniel.thompson@linaro.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-11-21, 10:09, Daniel Thompson wrote:
> A couple of small improvements to the dmatest documentation.
> 
> The first provides a description of what the test actually does.  The
> second corrects the description of how the test behaves if the channel
> parameter is not configured.

Applied, thanks

-- 
~Vinod
