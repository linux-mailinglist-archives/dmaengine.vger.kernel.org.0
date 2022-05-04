Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CF551B439
	for <lists+dmaengine@lfdr.de>; Thu,  5 May 2022 02:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiEEAFk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 May 2022 20:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383534AbiEDX5H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 May 2022 19:57:07 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719F64F9D5
        for <dmaengine@vger.kernel.org>; Wed,  4 May 2022 16:53:29 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-e656032735so2826665fac.0
        for <dmaengine@vger.kernel.org>; Wed, 04 May 2022 16:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ampHH5WJLIBWSsxWwzVjbk5pO9UBFxn81pZ6QIDzZtY=;
        b=jbmEQNvaFzriBuZmYrqOXqGDiwgtrAtwjB51LaAWw2rvxNNgsUuAdJO6a3VYHjyUy8
         PJ+tcf5enLe+syNzKue4ehkXJGGpdj/pAIHSI5o+u/3Jo85EMhF/woMYrhUjEhziIS6z
         sSoHnVRswhzBOXcrM7yFf66u0bXn8SEFYNHzcSjgynnC2oef5/IBCXEXyzXl/mCB4/er
         2BUoBduXPVTRvf/ajWrsNGg7uhQk4495Q4iAFncYS2pm74Va8UoRSr9+QUftX9WNW52b
         ORhjakwQmcx55J+zmEuMLXRy0La+FauaNihIbt+PKLt44PWDPtwfEsZluUd6pmpoLl2q
         nFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ampHH5WJLIBWSsxWwzVjbk5pO9UBFxn81pZ6QIDzZtY=;
        b=aBK4xAuer9sHEuDNNFCY8cdtD+zIe316dC1AwCMjNesJ/aDppl82oW9UeutvE4kjP5
         uKTzvKAdb0A50GnuKMjqJKOkeEk2epPE4Yhsc1mBwu0vJO5JF+t/tkSwuVtyCt/q2YAC
         RuGPm1t4aMAhoi6GnajnPDs+35Wm9Dvj3s4x9cyBwfc05xA691uF3+d5D6Xn+Putn3e5
         n8qX2kmCly3n67AIVNZfZ1qo6ck5ZJSpEJn9hhqBvEQ2HD+nNusLt2m+8ptB7EwbtsiX
         xD3ZZxSr1y4X3nLDoaQ5i+j3sxBD1eTJR3MVZKPnaa0p0oac+g6KzSg3VUEjXpqFYsPo
         1FjA==
X-Gm-Message-State: AOAM530V2pJ5cokkGuV+SnZ8Y/vjCi5nuSTJpbi3k27DIOJd2pbtQqHA
        Y2uWWCDvwjKHQAtoueSeFOf3Uilhb+vEeM1tP9s=
X-Google-Smtp-Source: ABdhPJxBk9kUGP8JsARUNQea2X3nUNa8J8u/QMke3swBSqQj2ZFnh/rtDDO26scRhyM6K+FOx9ctWIW+KcybkZeLHS4=
X-Received: by 2002:a05:6871:453:b0:ed:d2f8:8ecc with SMTP id
 e19-20020a056871045300b000edd2f88eccmr1026065oag.228.1651708408583; Wed, 04
 May 2022 16:53:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6802:1a9:0:0:0:0 with HTTP; Wed, 4 May 2022 16:53:28
 -0700 (PDT)
Reply-To: ortegainvestmmentforrealinvest@gmail.com
From:   Info <joybhector64@gmail.com>
Date:   Thu, 5 May 2022 05:23:28 +0530
Message-ID: <CAP7KLYhGtFJfSN95KTRoLnhiu4=3WoGWeZAKRN3zv7yG1VKfzg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:44 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [joybhector64[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [joybhector64[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

-- 
I am an investor. I came from the USA and I have many investments all
over the world.

I want you to partner with me to invest in your country I am into many
investment such as real Estate or buying of properties i can also
invest money in any of existing business with equity royalty or by %
percentage so on,
Warm regards
