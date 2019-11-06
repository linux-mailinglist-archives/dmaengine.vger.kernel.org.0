Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E66F1C2B
	for <lists+dmaengine@lfdr.de>; Wed,  6 Nov 2019 18:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbfKFRMB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Nov 2019 12:12:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbfKFRMB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 6 Nov 2019 12:12:01 -0500
Received: from localhost (unknown [106.51.111.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADD7321848;
        Wed,  6 Nov 2019 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573060320;
        bh=9jLowEpcnUR+hqUrDaAIf5NUb/9ZtFgLpQV4xEGzaJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cXy/Z6yfvDaZScq+vG9DciwSkOXcLR0CB22mMEoJ74IHk4VpByMLTWq8jjh70Mgeg
         VavB3KjwbRHLAQqV9oGFB6oRLebPqladVfVXuOpGHClQ/Q+SVu5wtEUlvsSFf/QgKd
         inqvbLhc3PchOemVkvVftZqkzpnF9mu9nK0G3Ucw=
Date:   Wed, 6 Nov 2019 22:41:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, paul@crapouillou.net,
        mark.rutland@arm.com, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com
Subject: Re: dmaengine: JZ4780: Add support for the X1000 v2
Message-ID: <20191106171156.GK952516@vkoul-mobl>
References: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
 <1571937670-30828-1-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571937670-30828-1-git-send-email-zhouyanjie@zoho.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-10-19, 01:21, Zhou Yanjie wrote:
> v1->v2:remove flag JZ_SOC_DATA_ALLOW_LEGACY_DT.
> 

Hmm this cover letter is devoid of any details for the series. One would
expect a description of the series attempting to address.

Neverthless I have applied, but in future please take care to write a
*decent* cover letter and also document changes as you done in the only
line.

Also auto generate the letter using --cover-letter option, it shows up
nice diff stat which helps while applying

Thanks

-- 
~Vinod
