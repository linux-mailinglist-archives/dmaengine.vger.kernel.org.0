Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA136FDED8
	for <lists+dmaengine@lfdr.de>; Wed, 10 May 2023 15:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbjEJNme (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 May 2023 09:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237166AbjEJNma (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 10 May 2023 09:42:30 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289FED046
        for <dmaengine@vger.kernel.org>; Wed, 10 May 2023 06:42:25 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-76fd0036c7fso2030631241.3
        for <dmaengine@vger.kernel.org>; Wed, 10 May 2023 06:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683726143; x=1686318143;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4kWzn6pxkecn7JMiXg/VymW/f2W9szhFxBJtG2FdMw=;
        b=J+gCXANpzfW9pGJxF0/g3gRl9VbgPOSBg8Y0uweRdlE0oJ+IacdGbObWUvWqNjz18W
         1a3mw8+JD61rc3xDEn+N0CmyuHKsWvBOUYA9l1FnQFO6UdZZCl1/Y2TuUwQA8nKugAcT
         AKsCUcXn53IK+RRe2EEUdVRFKaDR/8OXLAOMD2JYlFrtaA/BTAiddoKL1SnEKGOiWcpd
         MdgYD/DNw1C7p3nOFXnW/EFHTH8xr2ijg5tpmHeo1FypAuMs0GTdMwErI8DhiGcFthqZ
         kxIX/hrRgI/7LBbRQDveIqgHQk9LY/n3gjQrgqaAPhNuxM/vP9aDwCHcpK3kWoWH0moE
         MITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683726143; x=1686318143;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4kWzn6pxkecn7JMiXg/VymW/f2W9szhFxBJtG2FdMw=;
        b=f+ZG+AKP7ita+GqCXTCSOv4RU62rgG52eyvNDcFySu2vvhyfPk6hLAQGCvMwfAhqN1
         lDI2yNlJh8ZEit54+Gcd/Asx56+q0sNoBk+tWR9yEMcCOZceoRlJFuBh3yOcqEkyof1T
         h03QkpcVFaqhJTRHOfVXGk9lPyNGEzhAmbpcwb8PB1Acdyscme82uoXhN9tXwiKd5Fqh
         DFHIZigkrUsGPvQEFouGT8dqcFkG/MzwYYibIBEPPNvb218a2RFtt2PFb29Laen5KJ2x
         Aevs6a1DBR9WA0z0Ptgn3I7knuJjWkXG4Te8l0LBFEYGAfm3rHkPAqCCSgDZz1ohvTv7
         1yCw==
X-Gm-Message-State: AC+VfDwBrC1wF04MWUvachPxY+gdy0pPtUguqK9kBbZRZ3Pcm+HYmIkR
        1JeGEQSrqOi26XS0NDpsbBnmqU//L3jQk5yk5IA=
X-Google-Smtp-Source: ACHHUZ7mnf+7iAjzP2LCc3c+BIZ9z+/33DppYaplzJJBjj3QC0ccpNtKSk7lUTMOb0XGaX+jjKlLNZbhXBdooD7gBk8=
X-Received: by 2002:a67:f50a:0:b0:434:6958:cdc6 with SMTP id
 u10-20020a67f50a000000b004346958cdc6mr6714351vsn.19.1683726143567; Wed, 10
 May 2023 06:42:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:738b:0:b0:747:f1a8:4f69 with HTTP; Wed, 10 May 2023
 06:42:23 -0700 (PDT)
Reply-To: contact.ninacoulibaly@inbox.eu
From:   nina coulibaly <ninacoulibaly81.info@gmail.com>
Date:   Wed, 10 May 2023 06:42:23 -0700
Message-ID: <CAJws7AA_b5kiasWyX_k14eX6wKP_bKFGRW9UCXDSu=hMRtZgBQ@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dear ,

Please grant me the permission to share important discussion with you.
I am looking forward to hearing from you at your earliest convenience.

Best Regards.

Mrs. Nina Coulibaly
