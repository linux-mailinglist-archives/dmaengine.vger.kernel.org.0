Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA316DCEB7
	for <lists+dmaengine@lfdr.de>; Tue, 11 Apr 2023 03:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjDKBHp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Apr 2023 21:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDKBHo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Apr 2023 21:07:44 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8851998;
        Mon, 10 Apr 2023 18:07:43 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id a23so3832861qtj.8;
        Mon, 10 Apr 2023 18:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681175263; x=1683767263;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1hLrqE4wSe3o6g63qLOhZxHKSdtjB+1bkW11vE+53BU=;
        b=iOO9MYNwrJJbwWMFeKGo5zy76ioM3sHBDDo0pURGCME4GFWFBeY9kK34tJ+GIIwXjU
         qUqBW4eBovGzQQEmHCF4zcUJxd4qmINh/b+59dmENLmDpddk0/J7uURmGBQfQFQLXHGx
         ojN85q9MwMepf38x2/JpkJHAdkEcjFyS9QZ73lkYCZ4nXPqckLzViktY3oaxhKADMpdr
         DVxBS4mmvbUsj28KR1MfFXLVqDmRvOcgPbrHaqGNmqt6IR9B5Ki5eHJayqWvqmuP3m/5
         RH0G4kcHH9xq8qS/4isUj7M1+HnHD9+VUFnf8XK4xArEX1HRZry7InQU8k8gcP7sHlZy
         deqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681175263; x=1683767263;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1hLrqE4wSe3o6g63qLOhZxHKSdtjB+1bkW11vE+53BU=;
        b=jQ/+rO8aSO2CH4Q8HFHibIConla0IiV3aoFBjI63rIPBm7zr28SHIe89gqCRZFwRBP
         nZ+tSG1oPp7PFZriKS0F2J5j1a/O1bVj9hrxUAvpYPbXOWY50/7MdjdpX5t0SjDgMtVk
         Oxa1m3e2uQay2uCU9zYddIDrvCDwo2bP3Xfsfvn/Fw46rXilhT125PJhJRD9uOqvVg5a
         6mYGjatHTNhRAt0HiXRrClrMpURsMbBm/aSTEhBf+1f97Y7oaA2iwoPevAN2kflxoTwa
         oNQtabJhov6Ueb19rqCnwyyNd7qT//PGvs4yZaiXljRdDkbIaw2gp1SJrUfivhSYmMND
         lCyg==
X-Gm-Message-State: AAQBX9chy6OzB3XDMSVk+bfZyC63kHupM37L5+75tYGvrhnyw+RRsfgy
        KnmR3PwV4Y72d08Nj2QcyX0=
X-Google-Smtp-Source: AKy350ZrNnGzx1ovzzQMyfChxLysTJqYb1CRANxfS2vA/WgSPDPSShAmwrRkv0IbY7CQBgR7H/3xKQ==
X-Received: by 2002:a05:622a:1994:b0:3e4:d1a2:521d with SMTP id u20-20020a05622a199400b003e4d1a2521dmr21429110qtc.29.1681175262741;
        Mon, 10 Apr 2023 18:07:42 -0700 (PDT)
Received: from sinankaya-ThinkPad-P14s-Gen-2i (pool-173-79-31-112.washdc.fios.verizon.net. [173.79.31.112])
        by smtp.gmail.com with ESMTPSA id e18-20020a05620a015200b007441b675e81sm3626376qkn.22.2023.04.10.18.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 18:07:42 -0700 (PDT)
Message-ID: <f4ef55167b699a4fccba561182b0725a57ee5b11.camel@gmail.com>
Subject: Re: [PATCH] dmaengine: qcom_hidma: Add explicit platform_device.h
 and of_device.h includes
From:   Sinan Kaya <franksinankaya@gmail.com>
To:     Rob Herring <robh@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 10 Apr 2023 21:07:41 -0400
In-Reply-To: <20230410232654.1561462-1-robh@kernel.org>
References: <20230410232654.1561462-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 2023-04-10 at 18:26 -0500, Rob Herring wrote:
> qcom_hidma uses of_dma_configure() which is declared in of_device.h.
> 
> platform_device.h and of_device.h get implicitly included by
> of_platform.h,
> 
> but that is going to be removed soon.
> 
> 
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> 
> ---

Acked-by: Sinan Kaya <okaya@kernel.org>


