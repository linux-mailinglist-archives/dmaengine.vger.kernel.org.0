Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015F1639522
	for <lists+dmaengine@lfdr.de>; Sat, 26 Nov 2022 11:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiKZKFP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 26 Nov 2022 05:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKZKFO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 26 Nov 2022 05:05:14 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276371E3EF
        for <dmaengine@vger.kernel.org>; Sat, 26 Nov 2022 02:05:14 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id f68so3118026vkc.8
        for <dmaengine@vger.kernel.org>; Sat, 26 Nov 2022 02:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkLKKfAR5wqmVPeCqMY1O7lAxo0pbmpK+QeQEKfcsQQ=;
        b=UdC+yNhkMNEZmV6b37MRV+lAbM9oaclRcYSjU0otV/7sI8iNBTqvv9NEqtgBe/1xLg
         lTn/cVKjQ6Xpa/OO6eN1lA6ep8hSU61Ijcd8iChC8lYl5hc8F66Pbrx9IX0l0WpxqcGM
         6M8PsV8+bdQb8meX94cMHC3+0oKCJQNw+EFCDYGoTXyWS+7e+AUBiG/axqxVwLj1h5AB
         yh7qWfB58+Ftk+BzHaCdxF4SEwZhbLv4ssM0YxVC2N1Z9m26trU3+TM6kkojtI0M7zT2
         muGh6gkhPf1f00dgeoRCRVutTE5+LndlJuqyQnJ8YLcZ0d/anfK9ZY6bD2ZxiJq4gv+q
         uSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EkLKKfAR5wqmVPeCqMY1O7lAxo0pbmpK+QeQEKfcsQQ=;
        b=WkAw99tfiIjV+92RcyfHdsHEWc6R/AKlTO/9u1d3ang/tqRcRAmDqKtsuKvmwCEomY
         gasVLaEKxyrrvrGmoQU6A5itT1GeaPOKXZPG9ZPJiL0NbOUmegaX1Ux59EaaWnXdNYRy
         u5SaDfDzWLi+h6CjYJ2iA3lgsTv+xsc7e3ABOp2TS2qmDPC5qmUvBS0jonuK5zNZx6/p
         CJuFWlnxhSQ3y5IJuuhKQDsybdhZOuzNY+4MT60gExNxVq2UHCnGjGK/xB61ZDtTnmbJ
         l9WpWDLz4pikLADw81NpmK8FK2Glq7ffuAGn0xvxkyroq+YuhVQLRtRNTx5GUbF7y7HA
         D2lw==
X-Gm-Message-State: ANoB5pnnlXdATqWoZ4goOsUNEvHQnLA5P8c4kiU46CA1R5hiVQwB4JQ4
        CTcosE/M3QL2XKiilphsHCD8ZSgvDWrvu25uLt8=
X-Google-Smtp-Source: AA0mqf5RnzhOn6WxskSbJeKNPJgPZ64wSe6g31Y2bhpVetyGKwBEiYZv+MBgC8JMertcv+8rEfdFXTwOS9UwxkxXPSk=
X-Received: by 2002:a05:6122:2144:b0:3b8:1bb4:b750 with SMTP id
 m4-20020a056122214400b003b81bb4b750mr14099683vkd.20.1669457113247; Sat, 26
 Nov 2022 02:05:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:ccf1:0:b0:32b:6ae5:1eba with HTTP; Sat, 26 Nov 2022
 02:05:12 -0800 (PST)
Reply-To: ninacoulibaly03@myself.com
From:   nina coulibaly <ninacoulibaly13.info@gmail.com>
Date:   Sat, 26 Nov 2022 10:05:12 +0000
Message-ID: <CACTFrC2WnG3eYidXu2Kv5MGHsWzkj9v4p8udk+XD2i7EcK1DOQ@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_50,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a31 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5008]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ninacoulibaly13.info[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ninacoulibaly03[at]myself.com]
        *  2.0 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

-- 
Dear sir,

Please grant me permission to share a very crucial discussion with
you. I am looking forward to hearing from you at your earliest
convenience.

Mrs. Nina Coulibaly
