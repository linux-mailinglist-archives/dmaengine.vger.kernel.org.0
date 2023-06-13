Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A22072E92C
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 19:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbjFMRRB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 13:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbjFMRQv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 13:16:51 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D8819B9;
        Tue, 13 Jun 2023 10:16:48 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bc4ed01b5d4so2658243276.1;
        Tue, 13 Jun 2023 10:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686676608; x=1689268608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjLD3Z65AFUlnzGeDipyFAWU3jGU3OlZnyaKrjFl94c=;
        b=NJTC1I0w/bhJorLtWaQfWlvAtWyxNzM902NoozV2bocuew6IVQusNLYYsR92cHHh34
         unbOiMyrOlD3s/F94VX5GDu2SQjvEyrkkCVvXZv0vCl4WevU6AQ6ZIdMUFLUnckMLnKh
         1ggPVAdvsGV89dZLvZbdqcXLIhViqBG+eUvpfVmtpd9FUKi9KXDDsKu/A6ecBlK9bfFY
         U+GH0IuIyae8Z6r5rUNf6HTxjNB2s069SP7thqFKZP/qBRTz2uFWG6P8hHn/f7Y3ASQv
         h2+ET2Kjlc0MKvm5SWLSQbwT3w/z/0VybpT8padCUx9s5AgwciSPlOi/v4GahA52YR5P
         jKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686676608; x=1689268608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjLD3Z65AFUlnzGeDipyFAWU3jGU3OlZnyaKrjFl94c=;
        b=OOPnGeAGuQO83JzkBIkaJVhXvgdr4B5xPEmqxjqtk2u+JIO57cjDHq/1pEpxOo+G9r
         G4TT43m2QfT+XFZHAX/rfL11UXiJh5ONYefjkj7eS+uHu/gIz34GZh7p4MJHEnymKX4x
         UDNJwaNgSsRj7a8iSBcxGplTo0u7OxL/UpKPzAJJsk4Cz4Mef0ZU+OwpmF9l43Zd7gQh
         MyScbodXKxTtuDyGpzwtkiXbQRjWX9gjnP49E6QrLYpMMC+r4Hf12OfSpxqQMmAaOf6c
         0eDZBa7FDCx3gGmEyv+7JDpXsabdGrKoZ52g3r/p4hlwx/HfauNRYBdXY+VR4x2sUVXL
         8K4w==
X-Gm-Message-State: AC+VfDx5Yyf1I5hqE5xKvjO7CCdjiYk1aUnLTWdpuMbcPG4atvnJpV7n
        P3R7yPIRgzmYBsTk9PnyAWf0RUAqnqwtXAi+HxI=
X-Google-Smtp-Source: ACHHUZ51FK9fEEG9Y7UGxjZoDZTvO/ng3orwCtq1nFE6ZDFpN49YC8tIKpnu/txR4noRhPPPOhU9rPNQ8Cv9H8lanlM=
X-Received: by 2002:a25:8ca:0:b0:bc8:c035:cf4 with SMTP id 193-20020a2508ca000000b00bc8c0350cf4mr1912446ybi.17.1686676607731;
 Tue, 13 Jun 2023 10:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org> <20230612093537.614161713@infradead.org>
In-Reply-To: <20230612093537.614161713@infradead.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 13 Jun 2023 19:16:36 +0200
Message-ID: <CANiq72mTjNzLhfhax761CPDUHj=zC6qa6i3hobMWYaCvmgBAJQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/57] locking: Introduce __cleanup() based infrastructure
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com,
        masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, catalin.marinas@arm.com, will@kernel.org,
        vkoul@kernel.org, trix@redhat.com, ojeda@kernel.org,
        mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        dennis@kernel.org, tj@kernel.org, cl@linux.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rientjes@google.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        llvm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        rcu@vger.kernel.org, linux-security-module@vger.kernel.org,
        tglx@linutronix.de, ravi.bangoria@amd.com, error27@gmail.com,
        luc.vanoostenryck@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 11:39=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -77,6 +77,12 @@
>  #define __attribute_const__             __attribute__((__const__))
>
>  /*
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.=
html#index-cleanup-variable-attribute
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#cleanup
> + */
> +#define __cleanup(func)                        __attribute__((__cleanup_=
_(func)))
> +
> +/*
>   * Optional: only supported since gcc >=3D 9
>   * Optional: not supported by clang
>   *

`cleanup` goes before `const`, but apart from that, for compiler attributes=
:

    Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks for bringing RAII/SBRM to the kernel!

Rust also behaves like the `__cleanup__` attribute, e.g. iterating on
a loop destroys and constructs the variables defined inside the loop.
Also breaking to an outer label/scope.

By the way, maybe some of the macros in `cleanup.h` read a bit better
applying `clang-format` to it.

Cheers,
Miguel
