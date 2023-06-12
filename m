Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3802E72CBC6
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 18:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjFLQtH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 12:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbjFLQtF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 12:49:05 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B87B1B8;
        Mon, 12 Jun 2023 09:49:00 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b1ba50e50bso54474151fa.1;
        Mon, 12 Jun 2023 09:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686588538; x=1689180538;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=562o/MsrOYChmDHYEtCNvBVfOjip2qNAiCYOOBcbh88=;
        b=CV5mwy2U0+9+ebd7D8cXsG6rMrBoYvBH9E0/4jahlyZzvClH+qStd5QmzoYG/xVqur
         jnBBjuCBIIfnoXH9JbD+h5VDeGzARgsNhnLPolq+m9BfiuctDIU9sR12Yoe8Ec6FONoW
         fyQFBF9AESicv1AHngopvjaToOzuUaG1UtCdERlpK+8nnsySH2jgZC4OiBpEGE+GECAw
         blrAaHtjf+95qv4v3kgYL42o2+0HPXlBer9t0LFu4s5dVjUeuAc12NkS0Gyy3j1M1I/V
         79HCnuoIdQR6zG+uOpfBXoLe+bHWxrX5I62t3IQS34Xj/PIiuoNdmPGvU0QS8xtsYMuy
         8EtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686588538; x=1689180538;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=562o/MsrOYChmDHYEtCNvBVfOjip2qNAiCYOOBcbh88=;
        b=QsMsEUegl6+qilGU2x+ndgaNSErX0eQdh42UkWM62psF6iwQk5NYjFHOkX7+d7OUQU
         lClE95AytEX2MN4oiF8iMl35oZif/fc7k9SQL93qczrqRZLHtZPa0/fRkOpxPuSOdYT/
         I+A1nZTuHM0ZoiaAJ5BhzX17M32BszEW9UvOAU6SpJDNcY3LhHsj2WX4OAoa85UL7V78
         a7bPrgYZjv81Iu3w5C1qxscdqb8RIqqmctgd3mZtGvbVnCfI6BThL/POXEsWpvwkHCSP
         aZDgqyiddsRmq6JkT1u3Z+/Ff7BuvEoVUHCDa0Sw8eP2hje3CeMk9kOT7iEFrUz+ES5C
         QQlg==
X-Gm-Message-State: AC+VfDwC/3JWuxqQjouWqKMlx1B+qyMy7UdD1VPpHC875UWarKF9Px+W
        0ndd8gaZ9iHK7/vG9cPnOx8=
X-Google-Smtp-Source: ACHHUZ6nq0Et2EFYboIY2SYp8Iszf9G+fa1LnPAiY4L903T+8BvpfegVepTEN9QKrlqbeL+NbdKXsQ==
X-Received: by 2002:a2e:b050:0:b0:2b1:a4c2:70b4 with SMTP id d16-20020a2eb050000000b002b1a4c270b4mr3609311ljl.30.1686588538464;
        Mon, 12 Jun 2023 09:48:58 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id w13-20020a2e998d000000b00295a3a64816sm1845479lji.2.2023.06.12.09.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 09:48:58 -0700 (PDT)
Date:   Mon, 12 Jun 2023 19:48:56 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 0/9] Fix support of dw-edma HDMA NATIVE IP in remote setup
Message-ID: <20230612164856.xxi3ewxnfiagawz6@mobilestation>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
 <20230612105942.039b6fc0@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612105942.039b6fc0@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Köry

On Mon, Jun 12, 2023 at 10:59:42AM +0200, Köry Maincent wrote:
> On Fri,  9 Jun 2023 10:16:45 +0200
> Köry Maincent <kory.maincent@bootlin.com> wrote:
> 
> > From: Kory Maincent <kory.maincent@bootlin.com>
> > 
> > This patch series fix the support of dw-edma HDMA NATIVE IP.
> > I can only test it in remote HDMA IP setup with single dma transfer, but
> > with these fixes it works properly.
> > 
> > Few fixes has also been added for eDMA version. Similarly to HDMA I have
> > tested only eDMA in remote setup.
> 

> FYI it seems several patches of this series has been categorized as spam.
> I think it is because the code of these patches are quite similar.
> 
> Köry

Thanks for notifying about that. The entire series landed in my inbox.
So no problem has been spotted on my side. I'll have a closer look at
the patchset sometime on this week.

-Serge(y)

