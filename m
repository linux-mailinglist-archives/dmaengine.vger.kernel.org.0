Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E3C74D9AF
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jul 2023 17:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGJPS2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jul 2023 11:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGJPS1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Jul 2023 11:18:27 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82E9A0;
        Mon, 10 Jul 2023 08:18:26 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-440afc96271so1615371137.3;
        Mon, 10 Jul 2023 08:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689002306; x=1691594306;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nk/tMPeysHbj6DG2MWqpBx4I4BpKdtIsUv79T+mui8M=;
        b=SnqpO5UCkMrcTnl+PPgVLsLMk3yTDFyBZdQbJ4RwwIuak/JKzzThb4uYCR64tfHrj4
         MU4iYEHgLDaA+n5dewHkfX8YWRvu7v47cUxYVe+6WZEd3+iqQpltq8sdqiddtedwDl8T
         5DgX96BNY19CtJsJ5iKSYVYKOBzzIw9Z0wz1agPQbDW3gx4b/jgt+YSqn+5RZofHzSg+
         WYQj1flh8rCHzHCZxNEuaVYP9Tnl/EduL4KF6KgQVLubpfVx7BWWOzO1Y61w9vuY7fYX
         DHED3Iqxl5KEeeZn9rHDGZ/gVzJYlPtmR5/zUEUHGtI9Z+tCRWG0bZvz71CsNCo1VhyL
         O+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689002306; x=1691594306;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nk/tMPeysHbj6DG2MWqpBx4I4BpKdtIsUv79T+mui8M=;
        b=FFfozGQB0XHhk0cMuKSXy9Dzyn8P0qEhzuaa0gD6m8tlbBhb4U641Upd8BR4UHkoIJ
         8fJjsffI50JfUZwciW5RqTwSZb1/A9VEEcvbfwL9X/Ilz5LjVdoeFiwpZpq6rwuNmTOv
         YTQ2MQRmFXFmTO1oQ44MYLv+7covjB51GGQ5DdfSmI5MIAqP2tzJQyI7rlEidbHe3UES
         xQTsBbO0zvGZ2lKea8YnoAy7IVRtx84F0/aauTs1ZGY517V+k5faUPpBciu6dqjUJYYL
         DJHUs53Cp02Vn2vesMiOii5mZIJvZAorqP8oQhAadp5ItSrVuKnBFNbou2sGqtJC4qiW
         o+bg==
X-Gm-Message-State: ABy/qLbLzmaz8BQCaHK/Oh4Ls++NuE73NAFqq5nnTyxz+U3ly2eky5XC
        7W/hWhYsSqdjUg64uqvvnWE=
X-Google-Smtp-Source: APBJJlFeFyLL5NPCV2JXugyOjd4PAFNNHsbFoE2alRis3wt6fg1fTGiuEu30ypOCm7xnXGVcs18peA==
X-Received: by 2002:a67:f899:0:b0:443:69fd:362e with SMTP id h25-20020a67f899000000b0044369fd362emr5601647vso.16.1689002305583;
        Mon, 10 Jul 2023 08:18:25 -0700 (PDT)
Received: from sinankaya-ThinkPad-P14s-Gen-2i ([2600:4040:445f:b200:1342:c418:5933:82e4])
        by smtp.gmail.com with ESMTPSA id d15-20020a0ce44f000000b00623950fbe48sm5699939qvm.41.2023.07.10.08.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 08:18:25 -0700 (PDT)
Message-ID: <c04665563ada371e993153338aa856df3afa8469.camel@gmail.com>
Subject: Re: [PATCH] dmaengine: qcom_hidma: Update codeaurora email domain
From:   Sinan Kaya <franksinankaya@gmail.com>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>, okaya@kernel.org,
        vkoul@kernel.org, andersson@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
Date:   Mon, 10 Jul 2023 11:18:24 -0400
In-Reply-To: <20230707195003.6619-1-quic_jhugo@quicinc.com>
References: <20230707195003.6619-1-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 2023-07-07 at 13:50 -0600, Jeffrey Hugo wrote:
> The codeaurora.org email domain is defunct and will bounce.
> 
> 
> 
> Update entries to Sinan's kernel.org address which is the address in
> 
> MAINTAINERS for this component.
> 
> 
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> 
> ---

Acked-By: Sinan Kaya <okaya@kernel.org>



