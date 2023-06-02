Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C11371FFAB
	for <lists+dmaengine@lfdr.de>; Fri,  2 Jun 2023 12:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjFBKpS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Jun 2023 06:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbjFBKpR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Jun 2023 06:45:17 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F8B1B8;
        Fri,  2 Jun 2023 03:45:05 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1q51zk-00G3A9-IA; Fri, 02 Jun 2023 18:26:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Jun 2023 18:26:56 +0800
Date:   Fri, 2 Jun 2023 18:26:56 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org,
        vladimir.zapolskiy@linaro.org, rfoss@kernel.org,
        neil.armstrong@linaro.org, djakov@kernel.org, stephan@gerhold.net,
        Rob Herring <robh@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v8 05/11] dt-bindings: qcom-qce: Fix compatible
 combinations for SM8150 and IPQ4019 SoCs
Message-ID: <ZHnD8CykiC/VqjkG@gondor.apana.org.au>
References: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
 <20230526192210.3146896-6-bhupesh.sharma@linaro.org>
 <CAH=2NtwPhspRXD1g390c79+w1CFc19m+RcrzcCEtnGxomumhMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH=2NtwPhspRXD1g390c79+w1CFc19m+RcrzcCEtnGxomumhMQ@mail.gmail.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 29, 2023 at 11:45:54AM +0530, Bhupesh Sharma wrote:
>
> Bjorn has applied the dts patches from this series to his tree.
> As suggested by him, can you please pick patches [PATCH 5/11] and
> [PATCH 6/11] from this series via the 'crypto' tree.

OK I've applied patches 5 and 6.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
