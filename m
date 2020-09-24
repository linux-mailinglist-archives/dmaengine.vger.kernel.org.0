Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83BE277886
	for <lists+dmaengine@lfdr.de>; Thu, 24 Sep 2020 20:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgIXSdn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Sep 2020 14:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgIXSdn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Sep 2020 14:33:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7490FC0613CE;
        Thu, 24 Sep 2020 11:33:43 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c9500731208bb5d5e764a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9500:7312:8bb:5d5e:764a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E87E71EC032C;
        Thu, 24 Sep 2020 20:33:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600972422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=K1LDcbd/Xlk5U+odxBlbQnGbQUN44E5E+ypygEgBZGI=;
        b=rMjnL2w1/NZ7psxB5gLY8CPTZqcCC154PW4o8PRnG8meyMNE7ror2rSXZ6E4sOXB0TToXI
        Kph2cmmLUAUhxUaedcDRIRV5MEW25qik2kpiQL21hKs3Qlp89cUdV+2VehPkmYn2FGQlCU
        gSGh8TeSjWYQSVE6JapM+STwaZgkbdg=
Date:   Thu, 24 Sep 2020 20:33:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com,
        David.Laight@ACULAB.COM, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/5] x86/asm: Carve out a generic movdir64b() helper
 for general usage
Message-ID: <20200924183335.GP5030@zn.tnic>
References: <20200924180041.34056-1-dave.jiang@intel.com>
 <20200924180041.34056-2-dave.jiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200924180041.34056-2-dave.jiang@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Sep 24, 2020 at 11:00:37AM -0700, Dave Jiang wrote:
> The MOVDIR64B instruction can be used by other wrapper instructions. Move
> the asm code to special_insns.h and have iosubmit_cmds512() call the
> asm function.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Suggested-by: Michael Matz <matz@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
