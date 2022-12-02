Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839216405FB
	for <lists+dmaengine@lfdr.de>; Fri,  2 Dec 2022 12:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiLBLnE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Dec 2022 06:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbiLBLnC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Dec 2022 06:43:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02115B71F3;
        Fri,  2 Dec 2022 03:43:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE77FB8214A;
        Fri,  2 Dec 2022 11:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986B6C433D6;
        Fri,  2 Dec 2022 11:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669981378;
        bh=pdUKlgFaAZW4ra2WV3yNnhTKwFRVC6AFm4conLODUCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/rf5rFVofcm5/sbLjxbxa+snUXVrk76ewPFYtIm/Bl83qh5bJ10ml1mD138RjQyT
         yfWEGtDirv2n0DTahKwcRVEKf8ddM7iMz1DAPpXx206hdYl0Cp2EVpsKIuxkLKdXYK
         vfy580TrkYVO3VgEGIl+mkGFUh8L+0wqLV2JJOTOK39YhXZazycs3EraHiKYTOENyT
         G5osG7FHfpn+19K7TptouVE5dmuMpDdUV4nHXFZ/la6snpVAedU+U7uTRHccvt1MQA
         UoH1lfL+BZTPftoxMN8lhG9ZXXpzyeJjZizc7DdXvo9exqKwX3RMFg/HYNKb8+/TlX
         OLi8KO01NCsvg==
Date:   Fri, 2 Dec 2022 17:12:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        linux-kernel@vger.kernel.org,
        Simtec Linux Team <linux@simtec.co.uk>,
        linux-next@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: Re: Regression in dmaengine/next was removed
Message-ID: <Y4nkvT+R8t6eGrWj@matsya>
References: <20221021203329.4143397-14-arnd@kernel.org>
 <20221118215401.505480-1-u.kleine-koenig@pengutronix.de>
 <f0425349-d965-0a40-0672-27dfbe45eb44@linaro.org>
 <b759a3e7-7a45-3dc9-14ba-8b01da798f10@linaro.org>
 <20221125085117.23p7yv6wgo6b5l3v@pengutronix.de>
 <7f5cf3d8-4a3b-41eb-fed9-1ade4ba1e4e2@linaro.org>
 <20221202112003.kanwr7bixbaiqdgz@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221202112003.kanwr7bixbaiqdgz@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-12-22, 12:20, Uwe Kleine-König wrote:
> Hello,
> 
> I made the subject a bit more expressive.
> 
> On Fri, Nov 25, 2022 at 09:52:51AM +0100, Krzysztof Kozlowski wrote:
> > On 25/11/2022 09:51, Uwe Kleine-König wrote:
> > > On Sun, Nov 20, 2022 at 12:22:31PM +0100, Krzysztof Kozlowski wrote:
> > >> On 20/11/2022 11:31, Krzysztof Kozlowski wrote:
> > >>> On 18/11/2022 22:54, Uwe Kleine-König wrote:
> > >>>> The linux/platform_data/dma-s3c24xx.h header file was removed. It didn't
> > >>>> declare or define any symbol needed in devs.c though, so the #include
> > >>>> can just be dropped.
> > >>>>
> > >>>> Fixes: cccc46ae3623 ("dmaengine: remove s3c24xx driver")
> > >>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > >>>> ---
> > >>>
> > >>> The file was not removed... or it should not have been yet. The s3c24xx
> > >>> dma driver removal should be part of Arnd series taken via SoC ARM.
> > > 
> > > The patch enters next with the merge of
> > > 
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
> > > 
> > > Ah, the patch that became cccc46ae3623 (i.e. patch #14) is part of a
> > > bigger series. Its patch #1 removes s3c24xx.c (which you pointed out to be still
> > > broken) and patch #2 includes the change I suggested here.
> > > 
> > >> I think that commit should be just dropped instead.
> > > 
> > > +1
> > > 
> > > BTW, cccc46ae3623 is included in next since next-20221107 and breaks
> > > (at least) arm/s3c2410_defconfig. So I would consider reverting
> > > cccc46ae3623 a fix. (Added linux-next to Cc:)
> > 
> > Yes. The build failure of next was reported already by kernel test robot.
> > 
> > Vinod, can we drop this patch?
> 
> That patch is still contained in the next tags of this week. :-(

Apologies for delay, I was moving...

I have reverted and pushed now

Thanks for following up!

-- 
~Vinod
