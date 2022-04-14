Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6195006F6
	for <lists+dmaengine@lfdr.de>; Thu, 14 Apr 2022 09:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbiDNHiP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 03:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiDNHiN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 03:38:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C191C901
        for <dmaengine@vger.kernel.org>; Thu, 14 Apr 2022 00:35:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e21so5685310wrc.8
        for <dmaengine@vger.kernel.org>; Thu, 14 Apr 2022 00:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=KeMi8W+p20zdR41YZoRj2EapY7imNsLYkAgQIQsIzqY=;
        b=OYaKi6gFUvm0HSQM6TiZOaHDoschffAMhDgmT0pX3OaoWcKrcWew1x0phF9UPop6j3
         I82jwcANCV0X1kE8qYNrXj6CzQq6lIrkyE0waTUt7j8jBYqDFiQfLJK2aAe9KgoxclXc
         /hOfTpNOMfrXIjvnYtBHEEzgmMcxpHLRMKNdx8omnua8D9gCdq6L0cjae0LO/EvukxRQ
         v5EtRUes24b4DlzuSLbWbppMatxNPqkSB/rqqe4NWjC94ya6bUMJ3SEGRc6bzMVOEm68
         BbMV8lg/EO5IfNJNLs+PbcFXoRY1nVueoOfTjhaV7kWF/D69tQlRSe6mOYX2XigPqaeW
         /A4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=KeMi8W+p20zdR41YZoRj2EapY7imNsLYkAgQIQsIzqY=;
        b=lh6mbcIWGeHnDHPxhJQU8+jd7i3np9veCZUfG54R7nifBvwc6azpBNrhiaGskindxH
         mtGEEYe3JcwG4AGJp3aFwNz6WwRcy9JjfauUeJs/KA2BkAXOGX29NH9OpUkM+F1+V01Y
         Byrhsvb57fB5CgUSP8HkBS+Q+X0+t9VcEXOUfCC+WVoVirwP8mnqIRlUzlsn5XZDkVXV
         dRy5k5SJsytZCUzz6NenMLkfDGSHrE4i7boFoE07sPI6RymBob3Sw5cA2Q0Fds/Uur9m
         P1krbXZ3FB/03Z7KR93VYy/XlkO7HOkYj09Fs5sZ1+TL4KAy9iOrObkPv0nxUmrXzmWV
         vekA==
X-Gm-Message-State: AOAM531izanJtQe4PHn7CONQ1wXkSpyiJTZJL2WRSaAK0xz061ScDVVA
        u/IjUvx42kxvIipzd2l3WM8qf2dS8wwWw0nMLQ==
X-Google-Smtp-Source: ABdhPJyECEmkoXt7lgbKYslHRXS9xVvfkd4892WzYTfT4cg8n/OjafMXwzDpJQ3l5BBl+IV8DBPLVXDRdHGoX+IoBS0=
X-Received: by 2002:a5d:5690:0:b0:203:f727:362 with SMTP id
 f16-20020a5d5690000000b00203f7270362mr1056087wrv.717.1649921747468; Thu, 14
 Apr 2022 00:35:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:64cb:0:0:0:0:0 with HTTP; Thu, 14 Apr 2022 00:35:46
 -0700 (PDT)
Reply-To: danielseyba@yahoo.com
From:   Seyba Daniel <ouedraogoissa.bf@gmail.com>
Date:   Thu, 14 Apr 2022 09:35:46 +0200
Message-ID: <CAPdK0paBVRB2S2eHUh0A3myzsPaZY=afiTzgnft+AVZ8Wk2Dwg@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:443 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ouedraogoissa.bf[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

I am so sorry contacting you in this means especially when we have never
met before. I urgently seek your service to represent me in investing in
your region / country and you will be rewarded for your service without
affecting your present job with very little time invested in it.

My interest is in buying real estate, private schools or companies with
potentials for rapid growth in long terms.

So please confirm interest by responding back.

My dearest regards

Seyba Daniel
