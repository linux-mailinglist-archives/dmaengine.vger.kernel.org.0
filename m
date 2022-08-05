Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7D658A5AD
	for <lists+dmaengine@lfdr.de>; Fri,  5 Aug 2022 07:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbiHEFfp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Aug 2022 01:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbiHEFfn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 Aug 2022 01:35:43 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8B0641B
        for <dmaengine@vger.kernel.org>; Thu,  4 Aug 2022 22:35:42 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id c19so683954uat.6
        for <dmaengine@vger.kernel.org>; Thu, 04 Aug 2022 22:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=C9OtDfatTdiphdlWN7zsS/2P0Fjf45auQYVLd+4H5vo=;
        b=NmoAV89KdxgA4rltoSYGIudYCNZgnurOw7nDK4PsQfT//vlaM0HlM8GgEEeuGsbLQC
         2/wgHPd8kKxRVo2a5wXN9Qwll8x87mv6URisSZDKGR9/nSAv++4q9cjH4TnapOq1Ke7z
         r/Yv1qf/e1kVFovpixlPy2wz1OCvo2fM+bsdCSwofg9s7ej58dB0EhvdtMFVIGaeDhEI
         zVLPvjA1uPBmDUairg4IpxhRGAZgGCflVvLgb9j8apweegdLc3rMIgH88UTOQA5C7Fqo
         Do4zpuLWVdYDeohJvUVI81DkSOF4+dBxbqk7yd38Xj63Fc4fkFI4OT/CMDlKFkTnWT90
         yfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=C9OtDfatTdiphdlWN7zsS/2P0Fjf45auQYVLd+4H5vo=;
        b=Z19uadA8XLDjMUyCqCPGcNxCCqsPcNMMQIVWtpUNW4pKfiJvbfRlmtAyUblTvsNscx
         G1nxvubf7eSKN9097kQJ0WHpP71O523YzsnqXZkkw22hlyrmkVq2onIkTL6EF6YxwiJw
         v/t8XnxLJWNeh053KFn2TCXwLCGxAkORQYDitnwJY/YGLPzxOYHYDQqfMhm/ss8xx/iY
         tnCtRDaU/Ddb5N3dZuDDRRdD2LVa28CfTT224qYhM3AzXmIGMLgRz09eGFigOVdLMm2Z
         CwLWXGAmb1WkIUiatXVacPRlgm9u8aCXNMqofOomiKipP0I1gMjj/yfbjbsYTw/bf1Zi
         ZZWA==
X-Gm-Message-State: ACgBeo2Q1/RoNKUqa6FPIaX4PEGr4URgqjlMTVdV1H19tgYnf6eIgrG/
        s3kHyBGIJYd7E4JHY/dnDwWAOCG8tUsHLTHX6j8=
X-Google-Smtp-Source: AA6agR5KjIiGO+I1mltQ1X5bg6oKLLru/pS03dG3+9NXl8gjr4ilxu2zPbC0EQPg4vlik5RRwGdCkI0goNJK8IPmg9Q=
X-Received: by 2002:ab0:4e6:0:b0:378:f49d:233b with SMTP id
 93-20020ab004e6000000b00378f49d233bmr2440188uaw.3.1659677741318; Thu, 04 Aug
 2022 22:35:41 -0700 (PDT)
MIME-Version: 1.0
Sender: williamsjeff859@gmail.com
Received: by 2002:a59:7ce:0:b0:2d6:fc87:f288 with HTTP; Thu, 4 Aug 2022
 22:35:40 -0700 (PDT)
From:   Pavillion Tchi <tchipavillion7@gmail.com>
Date:   Fri, 5 Aug 2022 05:35:40 +0000
X-Google-Sender-Auth: ZAaVZfRDspjTc3Z3H32E_ArWJyY
Message-ID: <CANPnRmfXLLS4PSp4RLVzrb0mf9XRhgr4_WPhc3K9ZW7isLw=DQ@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

-- 
Hallo
Haben Sie meine vorherige E-Mail erhalten?
