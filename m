Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274BD17BF2A
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2020 14:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCFNjS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Mar 2020 08:39:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgCFNjS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Mar 2020 08:39:18 -0500
Received: from localhost (unknown [122.178.250.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BF312072D;
        Fri,  6 Mar 2020 13:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583501958;
        bh=3tDdbKxAaQxlXGa1ABfrKIRu1BxxzYmw1J4oe8Kh6x4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kN5Nv8a54WiDwk4wfaM8Os2GcjQVTbDIbyj+argTNBXWzKVK7LqPQlMth4CkkVoU0
         iu9H3N/MkyjMML3DlF9LnWZmq0veb+sdxmVZSB0zxolXWiv1RAbitXlfAFfXXHjdRm
         VqXVNZaBx6ESCVLSWOP7N8eWgSmWLvROEGQK5xKE=
Date:   Fri, 6 Mar 2020 19:09:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/9] docs: dmaengine: provider.rst: get rid of some
 warnings
Message-ID: <20200306133914.GJ4148@vkoul-mobl>
References: <afbe367ccb7b9abcb9fab7bc5cb5e0686c105a53.1583250595.git.mchehab+huawei@kernel.org>
 <62cf2a87b379a92c9c0e5a40c2ae8a138b01fe0a.1583250595.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62cf2a87b379a92c9c0e5a40c2ae8a138b01fe0a.1583250595.git.mchehab+huawei@kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-03-20, 16:50, Mauro Carvalho Chehab wrote:
> Get rid of those warnings by adding extra blank lines:
> 
>     Documentation/driver-api/dmaengine/provider.rst:270: WARNING: Unexpected indentation.
>     Documentation/driver-api/dmaengine/provider.rst:273: WARNING: Block quote ends without a blank line; unexpected unindent.
>     Documentation/driver-api/dmaengine/provider.rst:288: WARNING: Unexpected indentation.
>     Documentation/driver-api/dmaengine/provider.rst:290: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> While here, use parenthesis after get_metadata_ptr/set_metadata_len,
> as, if some day someone adds a kerneldoc markup for those, it
> should automatically generate a cross-reference to them.

Applied, thanks

-- 
~Vinod
