Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB35D577D1A
	for <lists+dmaengine@lfdr.de>; Mon, 18 Jul 2022 10:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiGRIFW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Jul 2022 04:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbiGRIFV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Jul 2022 04:05:21 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AB065BD
        for <dmaengine@vger.kernel.org>; Mon, 18 Jul 2022 01:05:20 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d12so17966001lfq.12
        for <dmaengine@vger.kernel.org>; Mon, 18 Jul 2022 01:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=satlab.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=lI2pF+MyAfTvAZEEpQaoOz9tN/rdvUajJ/N5Ua+djXM=;
        b=unH59UMNefrVHuM3ShJeWVlM3TyX6udGdV1J04nUzsrhMs1VgZZKZbKrSqs79VFirF
         5CiXRuWhzm6JBT/10yLu6/yK+Xe2WWARGTk43mIX+wLDeWgKiO1qx/rucQubP346BO6X
         21CUiDvoERUrwzY64ALSGSG9+BNpPgET/wHYMmGVz7GduK4o2uYPsD7Y1HbRRJZXK8I/
         6g06TnKf2/wL/0REfnAOXQL+NI4x4+b8uxw/11GMGUMrYEXKDtDRV6iY8SfFNliE8r0f
         FYUxk4MBDwNyIcSaRWx4ZW/ZuGFJxxsAh9E+aShZpG/eswMe3GSdjcZNKghZPBHGZy6f
         XILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=lI2pF+MyAfTvAZEEpQaoOz9tN/rdvUajJ/N5Ua+djXM=;
        b=DzCy0SOPKTDOC+LqPJe/UhHyH+MahUYCGn0aOWuSB0DGRru1w9exxOHjnBVgJxu6ys
         ZWrxO6WtMAz/BMCjLvhgj7j2Usn16NYDw6JKsreBZJ1fVbPdalHjkgvt/SxXqy4V96wR
         9pYT/uU5Ax6HcREG8KRBr0nL9d+8eNvX0iL53SuqzlcPu+ZuOGjeSLPbM96+cDy415Y8
         5/nQcGQPIry7iTXoUDYaIzIy8cNUnJgA6wz9WrsbqN+2ti0vdPYLkQus8PTB3jQK65WX
         EQ7q7xPTfIhsstuytfN6yEQ+m0sBrW5AcKgbnyZG2RupGhH9Kg9bevHVQtDAqzQdx6hl
         ND6Q==
X-Gm-Message-State: AJIora+M9QKfy8hLJN3znPa/lT8k03f7Cg0r4pJtD8Vea9ezPPCq9+ab
        WHSSZogEdfRCtIbhoHRH380c5hkuLlE6Dy3W
X-Google-Smtp-Source: AGRyM1uHWM35ulh182BYTbk+Rvg7n+SjMdmJS1aEmDojP+1yLFa6kWMzZKAIGQU7e2Os7ngdJGXmWw==
X-Received: by 2002:a05:6512:2527:b0:48a:3175:d647 with SMTP id be39-20020a056512252700b0048a3175d647mr5453709lfb.326.1658131518377;
        Mon, 18 Jul 2022 01:05:18 -0700 (PDT)
Received: from tausen-desktop.satlab.com ([77.243.61.235])
        by smtp.gmail.com with ESMTPSA id i10-20020a2ea22a000000b0025d9552fcafsm1975037ljm.97.2022.07.18.01.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 01:05:17 -0700 (PDT)
References: <20220714110644.2849191-1-mta@satlab.com>
 <PH0PR03MB6786D02B3DDFAD0B13A975DB998B9@PH0PR03MB6786.namprd03.prod.outlook.com>
User-agent: mu4e 1.6.10; emacs 28.1
From:   Mathias Tausen <mta@satlab.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] dmaengine: axi-dmac: check cache coherency register
Date:   Mon, 18 Jul 2022 09:31:35 +0200
In-reply-to: <PH0PR03MB6786D02B3DDFAD0B13A975DB998B9@PH0PR03MB6786.namprd03.prod.outlook.com>
Message-ID: <8735eyj176.fsf@satlab.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> BTW, Mathias you should +cc the maintainers... Take a look at
>
> scripts/get_maintainer.pl

Thanks, Nuno.

+CC: Vinod

- Tausen
